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
				while (reader.ReadLine(out string line))
				{
					string[] data = line.Split(new char[] {' ', '\t'}, StringSplitOptions.RemoveEmptyEntries);
					Player p = null!;
					switch (data[1])
					{
						case "Polgar":
							p = new Citizen(data[0], int.Parse(data[2]));
							break;
						case "Orvos":
							p = d = new Doctor(data[0], int.Parse(data[2]));
							break;
						case "Gyilkos":
							List<string> deathList = new();
							for (int i = 3; i < data.Length; i++)
							{
								deathList.Add(data[i]);
							}
							p = k = new Killer(data[0], int.Parse(data[2]), deathList);
							break;
						default:
							throw new Exception();
					}
					players.Add(p);
				}
				Game g = new Game(d, k, players);
				g.Run();
				if (g.CityWon())
				{
					Console.WriteLine("város");
				} else
				{
					Console.WriteLine(g.Killer.Name);
				}
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