defmodule Playground.Infrastructure.Repo.Migrations.CreateOrder do
  use Ecto.Migration

  def change do
    create table(:order, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, :uuid
      add :timestamp, :utc_datetime
    end

    create table(:order_item, primary_key: false) do
      add :order_id, :uuid, primary_key: true
      add :row_number, :integer, primary_key: true
      add :description, :string
      add :qty, :integer
      add :price_amount_in_mills, :integer
      add :price_currency, :string
    end
  end
end
