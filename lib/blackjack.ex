defmodule Blackjack do
  alias Resultado, as: Mostrar

  def valores(valorA) do
    [
      {"A", valorA},
      {"1", 1},
      {"2", 2},
      {"3", 3},
      {"4", 4},
      {"5", 5},
      {"6", 6},
      {"7", 7},
      {"8", 8},
      {"9", 9},
      {"10", 10},
      {"J", 10},
      {"K", 10},
      {"Q", 10}
    ]
  end

  def figura(valorA) do
    [
      %{figura: "trebol", valor: valores(valorA) |> Enum.random()},
      %{figura: "corazon", valor: valores(valorA) |> Enum.random()},
      %{figura: "pica", valor: valores(valorA) |> Enum.random()},
      %{figura: "diamante", valor: valores(valorA) |> Enum.random()}
    ]
  end

  def sel_carta(puntaje) do
    valorA = if puntaje >= 10, do: 1, else: 11
    figura(valorA) |> Enum.random()
  end

  def calcular_puntaje(player) do
    Enum.reduce(player, 0, fn %{valor: {_, valor}}, acumulado -> acumulado + valor end)
  end

  def jugar(ronda, jugador, cpu) do
    IO.puts("Ronda #{ronda} \n")

    IO.inspect(jugador, label: "Jugador ")
    puntajeJugador = calcular_puntaje(jugador)
    IO.puts("Puntaje jugador: #{puntajeJugador} \n")

    IO.inspect(cpu, label: "CPU ")
    puntajeCPU = calcular_puntaje(cpu)
    IO.puts("Puntaje cpu: #{puntajeCPU} \n")

    rta = IO.gets("\nRobar carta? S/N ==> ")
    IO.puts("-------------------------------------------------------------------\n")

    if puntajeCPU <= 21 and puntajeJugador <= 21 do
      if String.contains?(rta, ["S", "s"]) do
        jugar(
          ronda + 1,
          jugador ++ [sel_carta(puntajeJugador)],
          cpu ++ [sel_carta(puntajeCPU)]
        )
      else
        Mostrar.resultado_blackjack([1, jugador, cpu])
      end
    else
      Mostrar.resultado_blackjack([0, jugador, cpu])
    end
  end

  def iniciar_juego() do
    jugador = []
    cpu = []

    IO.puts("\n-------------------------------------------------------------------")
    jugar(1, jugador ++ [sel_carta(0)], cpu ++ [sel_carta(0)])
  end
end
