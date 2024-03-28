defmodule GetawaysWeb.Schema.Schema do
  use Absinthe.Schema
  alias Getaways.{Accounts, Vacation}

  import_types Absinthe.Type.Custom

  query do
    @desc "Get a place by the slug"
    field :place, :place do
      arg :slug, string, non_null(:string)
      resolve fn _, %{slug: slug}, _ ->
        {:ok, Vacation.get_place_by_slug!(slug)}
      end
    end

    @desc "Get a list of places"
    field :places, list_of(:place) do
       arg :limit, :integer
       arg :order, type: :sort_order, default_value: :asc
       arg :filter,
       resolve fn _, args, _ ->
        {:ok, Vacation.list_places(args)}
       end
    end
  end

  input_object :place_filter do
    field :matching, :string
    field :wifi, :boolean
    field :pet_friendly, :boolean
    field :pool, :boolean
    field :guest_count, :integer
    field :available_between, :date_range
  end

  input_object :date_range do
    field :start_date, non_null(:date)
    field :end_date, non_null(:date)
  end

  enum :sort_order do
    value :asc
    value :desc
  end

  object :place do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :location, non_null(:string)
    field :slug, non_null(:string)
    field :description, non_null(:string)
    field :max_guests, non_null(:integer)
    field :pet_friendly, non_null(:boolean)
    field :pool, non_null(:boolean)
    field :wifi, non_null(:boolean)
    field :price_per_night, non_null(:decimal)
    field :image, non_null(:string)
    field :image_thumbnail, non_null(:string)
  end

end
