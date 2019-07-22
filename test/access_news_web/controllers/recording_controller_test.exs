defmodule AccessNewsWeb.RecordingControllerTest do
  use AccessNewsWeb.ConnCase

  alias AccessNews.Media

  @create_attrs %{recorded_at: ~N[2010-04-17 14:00:00]}
  @update_attrs %{recorded_at: ~N[2011-05-18 15:01:01]}
  @invalid_attrs %{recorded_at: nil}

  def fixture(:recording) do
    {:ok, recording} = Media.create_recording(@create_attrs)
    recording
  end

  describe "index" do
    test "lists all recordings", %{conn: conn} do
      conn = get(conn, Routes.recording_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Recordings"
    end
  end

  describe "new recording" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.recording_path(conn, :new))
      assert html_response(conn, 200) =~ "New Recording"
    end
  end

  describe "create recording" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.recording_path(conn, :create), recording: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.recording_path(conn, :show, id)

      conn = get(conn, Routes.recording_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Recording"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.recording_path(conn, :create), recording: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Recording"
    end
  end

  describe "edit recording" do
    setup [:create_recording]

    test "renders form for editing chosen recording", %{conn: conn, recording: recording} do
      conn = get(conn, Routes.recording_path(conn, :edit, recording))
      assert html_response(conn, 200) =~ "Edit Recording"
    end
  end

  describe "update recording" do
    setup [:create_recording]

    test "redirects when data is valid", %{conn: conn, recording: recording} do
      conn = put(conn, Routes.recording_path(conn, :update, recording), recording: @update_attrs)
      assert redirected_to(conn) == Routes.recording_path(conn, :show, recording)

      conn = get(conn, Routes.recording_path(conn, :show, recording))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, recording: recording} do
      conn = put(conn, Routes.recording_path(conn, :update, recording), recording: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Recording"
    end
  end

  describe "delete recording" do
    setup [:create_recording]

    test "deletes chosen recording", %{conn: conn, recording: recording} do
      conn = delete(conn, Routes.recording_path(conn, :delete, recording))
      assert redirected_to(conn) == Routes.recording_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.recording_path(conn, :show, recording))
      end
    end
  end

  defp create_recording(_) do
    recording = fixture(:recording)
    {:ok, recording: recording}
  end
end
