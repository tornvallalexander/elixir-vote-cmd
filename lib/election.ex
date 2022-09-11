defmodule Election do
  defstruct(
    name: "Mayor",
    candidates: [
      Candidate.new(1, "Will Ferrell"),
      Candidate.new(2, "Kristen Wiig"),
    ],
    next_id: 3
  )

  def view_header(election) do
    [
      "Election for #{election.name}\n",
    ]
  end

  def view_body(election) do
    election.candidates
    |> sort_candidates_votes_by_desc()
    |> format_candidates()
    |> add_body_headers()
  end

  defp sort_candidates_votes_by_desc(candidates) do
    candidates
    |> Enum.sort(&(&1.votes >= &2.votes))
  end

  defp format_candidates(candidates) do
    candidates
    |> Enum.map(fn %{id: id, name: name, votes: votes} -> "#{id}\t#{votes}\t#{name}\n" end)
  end

  defp add_body_headers(candidates) do
    [
      "ID\tVotes\tName\n",
      "-------------------------------\n"
      | candidates
    ]
  end
end

