  defmodule Rumbl.Accounts.Video do
    use Ecto.Schema
    import Ecto.Changeset


    schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string


    belongs_to :user, Rumbl.User
    belongs_to :category, Rumbl.Accounts.Category

    timestamps()
  end

  @required_fields ~w(url title description)
  @optional_fields ~w(category_id)

  @doc false
  def changeset(video, attrs \\ %{}) do
    video
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required([:url, :title, :description])
  end

end
