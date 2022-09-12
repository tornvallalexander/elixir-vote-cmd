defmodule Election do
  defstruct(
    name: "Mayor",
    candidates: [
      Candidate.new(1, "Will Ferrell"),
      Candidate.new(2, "Kristen Wiig"),
    ],
    next_id: 3
  )

  def run() do
    %Election{} |> run()
  end

  def run(election = %Election{}) do
    [IO.ANSI.clear(), IO.ANSI.cursor(0, 0)]
    |> IO.write()

    election
    |> view()
    |> IO.write()

    command = IO.gets(">")

    election
    |> update(command)
    |> run()
  end

  def update(election, cmd) when is_binary(cmd) do
    update(election, String.split(cmd))
  end

  def update(election, ["n" <> _rest | args]) do
    name = Enum.join(args, " ")
    Map.put(election, :name, name)
  end

  def update(election, ["a" <> _rest | args]) do
    name = Enum.join(args, " ")
    candidate = Candidate.new(election.next_id, name)
    candidates = [candidate | election.candidates]
    election
    |> Map.put(:candidates, candidates)
    |> Map.put(:next_id, election.next_id + 1)
  end

  def update(election, ["v" <> _rest, id]) do
    vote(election, Integer.parse(id))
  end

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

  defp vote(election, {id, ""}) do
    candidates = Enum.map(election.candidates, &maybe_inc_vote(&1, id))
    Map.put(election, :candidates, candidates)
  end

  defp maybe_inc_vote(candidate, id) when is_integer(id) do
    maybe_inc_vote(candidate, candidate.id == id)
  end

  defp maybe_inc_vote(candidate, _inc_vote = false), do: candidate

  defp maybe_inc_vote(candidate, _inc_vote = true) do
    Map.update!(candidate, :votes, &(&1 + 1))
  end

  defp vote(election, _errors), do: election

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

