defmodule Resultado do
  alias Blackjack, as: Operaciones

  def resultado_blackjack(result) do
    IO.puts("-------------------------------------------------------------------")
    IO.puts("Juego terminado")
    [r, j, c] = result
    nr = r

    puntajeJugador = Operaciones.calcular_puntaje(j)
    puntajeCPU = Operaciones.calcular_puntaje(c)

    if nr == 0 do
      if puntajeCPU <= 21 do
        IO.puts("Gana CPU")
      else
        if puntajeJugador <= 21 do
          IO.puts("Gana Jugador")
        else
          IO.puts("No hay un ganador")
        end
      end
    else
      if puntajeCPU > puntajeJugador do
        IO.puts("Gana CPU")
      else
        IO.puts("Gana jugador")
      end
    end
  end
end
