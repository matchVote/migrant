defmodule Migrant.RepsToOfficialsTest do
  use Migrant.RepoCase
  alias Migrant.{Repo, RepsToOfficials}
  alias Migrant.Schemas.{Official, Representative}

  test "official ids are replaced with their corresponding rep ids" do
    create_reps()
    create_officials()
    RepsToOfficials.transfer_ids()

    refute Repo.get(Official, "a6098c28-3325-478a-913b-ef8f0f9e010f")

    Repo.get!(Official, "93787582-f08b-4f6f-a1e2-38277154852f")
    |> assert_transfer(first_name: "Arcus", middle_name: "Training", last_name: "Post")

    Repo.get!(Official, "3b53f0c8-40ff-462e-b962-7338b58f035e")
    |> assert_transfer(first_name: "Flashlight", middle_name: "", last_name: "Tinkerbell")

    assert old_records() == [nil, nil]
  end

  defp assert_transfer(official, data) do
    assert official.first_name == data[:first_name]
    assert official.middle_name == data[:middle_name]
    assert official.last_name == data[:last_name]
  end

  defp create_reps do
    [
      %{
        id: "a6098c28-3325-478a-913b-ef8f0f9e010f",
        first_name: "Bob",
        middle_name: "J.",
        last_name: "Newhart",
        slug: "bob-newhart"
      },
      %{
        id: "93787582-f08b-4f6f-a1e2-38277154852f",
        first_name: "Arcus",
        middle_name: "Training",
        last_name: "Post",
        slug: "arcus-post"
      },
      %{
        id: "3b53f0c8-40ff-462e-b962-7338b58f035e",
        first_name: "Flashlight",
        middle_name: "",
        last_name: "Tinkerbell",
        slug: "flashlight-tinkerbell"
      }
    ]
    |> Enum.map(&Ecto.Changeset.change(%Representative{}, &1))
    |> Enum.each(&Repo.insert/1)
  end

  defp create_officials do
    [
      %{
        id: "c3c1da6e-97a1-4bf4-975d-bbaa8f9e72f5",
        first_name: "Bob",
        middle_name: "John",
        last_name: "Newhart",
        mv_key: "bob-j-newhart"
      },
      %{
        id: "e5a8038b-1f49-434b-84af-e614018470b6",
        first_name: "Arcus",
        middle_name: "Training",
        last_name: "Post",
        mv_key: "arcus-training-post"
      },
      %{
        id: "575098c8-cdf8-4ba6-892b-b65654bbe8eb",
        first_name: "Flashlight",
        middle_name: "",
        last_name: "Tinkerbell",
        mv_key: "flashlight-tinkerbell"
      }
    ]
    |> Enum.map(&Ecto.Changeset.change(%Official{}, &1))
    |> Enum.each(&Repo.insert/1)
  end

  defp old_records do
    [
      Repo.get(Official, "e5a8038b-1f49-434b-84af-e614018470b6"),
      Repo.get(Official, "575098c8-cdf8-4ba6-892b-b65654bbe8eb")
    ]
  end
end
