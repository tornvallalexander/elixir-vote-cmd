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
    |> Enum.sort(&(&1.votes >= &2.votes))
    |> Enum.map(fn %{id: id, name: name, votes: votes} ->
      "#{id}\t#{votes}\t#{name}\n"
    end)
    |> (fn candidates ->
        [
          "ID\tVotes\tName\n",
          "-------------------------------\n"
          | candidates
        ]
    end).()
  end
end

