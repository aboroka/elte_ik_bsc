using System;

namespace SleepingCity
{
	public class Program
	{
		public static void Main(string[] args)
		{
			try
			{
				TextFile.TextFileReader reader = new("input.txt");
				List<Player> players = new();
				Killer k = null!;
				Doctor d = null!;
				Server s = Server.Instance();
				while (reader.ReadLine(out string line))
				{
					if (line == "#")
					{
						Game g = new Game(d, k, players);
						g.Run();
						s.AddGame(g);
						players = new();
						k = null!;
						d = null!;
						continue;
					}
					string[] data = line.Split(new char[] {' ', '\t'}, StringSplitOptions.RemoveEmptyEntries);
					IPersonality personality = null!;
					switch (data[1])
					{
						case "Intro":
							personality = Intro.Instance();
							break;
						case "Extro":
							personality = Extro.Instance();
							break;
						default:
							throw new Exception();
					}
					Player p = null!;
					switch (data[2])
					{
						case "Polgar":
							p = new Citizen(data[0], int.Parse(data[3]), personality);
							break;
						case "Orvos":
							p = d = new Doctor(data[0], int.Parse(data[3]), personality);
							break;
						case "Gyilkos":
							List<string> deathList = new();
							for (int i = 4; i < data.Length; i++)
							{
								deathList.Add(data[i]);
							}
							p = k = new Killer(data[0], int.Parse(data[3]), personality, deathList);
							break;
						default:
							throw new Exception();
					}
					players.Add(p);
				}
                Game g1 = new Game(d, k, players);
                g1.Run();
                s.AddGame(g1);
                Console.WriteLine($"{s.SuccessfulDefenses()} {(s.AllFriendly() ? "igaz" : "hamis")}");
			}
			catch (Killer.PlayerNotFoundException)
			{
				Console.WriteLine("Gyilkos által keresett játékost nem lehetett megtalálni!");
			}
			catch (FileNotFoundException)
			{
				Console.WriteLine("Megadott fájl nem található!");
			}
		}
	}
}