defmodule Election do
  defstruct(
    name: "Mayor",
    candidates: [
      Candidate.new(1, "Will Ferrell"),
      Candidate.new(2, "Kristen Wiig"),
    ],
    next_id: 3
  )

  def view(election) do 
    [
      view_header(election),
      view_body(election),
      view_footer(),
    ]
  end

  def view_header(election) do
    [
      "Election for #{election.name}",
      add_whitespace(),
    ]
  end

  def view_body(election) do
    election.candidates
    |> sort_candidates_votes_by_desc()
    |> format_candidates()
    |> add_body_headers()
  end

  def view_footer() do
    [
      add_whitespace(),
      "commands: (n)ame <election>, (a)dd <candidate>, (v)ote <id>, (q)uit",
      add_whitespace(),
    ]
  end

  defp add_whitespace() do
    "\n"
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

