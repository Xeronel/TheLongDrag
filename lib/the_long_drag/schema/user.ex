defmodule TheLongDrag.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias TheLongDrag.Repo
  alias TheLongDrag.Schema.User

  schema "users" do
    field :username
    field :pwhash
    field :first_name
    field :last_name
    field :email
    field :password, :string, virtual: true
    field :user_timezone, :string, default: "America/New_York"
    field :last_ip, EctoNetwork.INET
    field :last_seen, :utc_datetime
    field :pw_modified_at, :utc_datetime
    timestamps()
  end

  def login(user = %User{}), do: login(user.username, user.password)

  def login(username, password) do
    result = Repo.one(from(
      User,
      where: [
        username: ^username,
        pwhash: fragment("crypt(?, pwhash)", ^password)
      ]
    ), log: false)

    case result do
      x when is_map(result) -> {:ok, x}
      _ -> {:fail, "Username or password is incorrect."}
    end
  end

  def signup(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :first_name, :last_name, :username, :password, :user_timezone, :last_ip])
    |> validate_required([:email, :first_name, :last_name, :username, :password, :user_timezone])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8, required: true)
    |> validate_confirmation(:password, message: "Passwords do not match", required: true)
    |> update_change(:email, &String.downcase/1)
    |> update_change(:username, &String.downcase/1)
    |> create_pwhash()
    |> unique_constraint(:email, message: "Email is already in use.")
    |> unique_constraint(:username, message: "Username is already in use.")
  end

  defp create_pwhash(changeset) do
    password = get_change(changeset, :password)
    # Create password hash
    {:ok, %{rows: [[pwhash | _] | _]}} =
      Repo.query(
        "SELECT crypt($1, gen_salt('bf'))",
        [password],
        log: false
      )
    change(changeset, %{pwhash: pwhash})
  end
end
