defmodule AccessNews.MediaTest do
  use AccessNews.DataCase

  alias AccessNews.Media

  describe "recordings" do
    alias AccessNews.Media.Recording

    @valid_attrs %{recorded_at: ~N[2010-04-17 14:00:00]}
    @update_attrs %{recorded_at: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{recorded_at: nil}

    def recording_fixture(attrs \\ %{}) do
      {:ok, recording} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Media.create_recording()

      recording
    end

    test "list_recordings/0 returns all recordings" do
      recording = recording_fixture()
      assert Media.list_recordings() == [recording]
    end

    test "get_recording!/1 returns the recording with given id" do
      recording = recording_fixture()
      assert Media.get_recording!(recording.id) == recording
    end

    test "create_recording/1 with valid data creates a recording" do
      assert {:ok, %Recording{} = recording} = Media.create_recording(@valid_attrs)
      assert recording.recorded_at == ~N[2010-04-17 14:00:00]
    end

    test "create_recording/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Media.create_recording(@invalid_attrs)
    end

    test "update_recording/2 with valid data updates the recording" do
      recording = recording_fixture()
      assert {:ok, %Recording{} = recording} = Media.update_recording(recording, @update_attrs)
      assert recording.recorded_at == ~N[2011-05-18 15:01:01]
    end

    test "update_recording/2 with invalid data returns error changeset" do
      recording = recording_fixture()
      assert {:error, %Ecto.Changeset{}} = Media.update_recording(recording, @invalid_attrs)
      assert recording == Media.get_recording!(recording.id)
    end

    test "delete_recording/1 deletes the recording" do
      recording = recording_fixture()
      assert {:ok, %Recording{}} = Media.delete_recording(recording)
      assert_raise Ecto.NoResultsError, fn -> Media.get_recording!(recording.id) end
    end

    test "change_recording/1 returns a recording changeset" do
      recording = recording_fixture()
      assert %Ecto.Changeset{} = Media.change_recording(recording)
    end
  end
end
