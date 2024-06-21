using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TextFile;

namespace PetStore
{
    public class InFile
    {
        private readonly TextFileReader reader;
        public InFile(string path)
        {
            reader = new TextFileReader(path);
        }
        public void Read(out Allatkereskedes k)
        {
            Allatkereskedes k1 = new Allatkereskedes();
            k = null!;
            for (int i = 0; i < 3; i++)
            {
                bool l = reader.ReadLine(out string line);
                k = null!;
                if (l)
                {
                    string[] separators = { };
                    int db = 0;
                    string type = "";

                    separators = new string[] { " ", "\t" };
                    string[] tokens = line.Split(separators, StringSplitOptions.RemoveEmptyEntries);
                    db = Convert.ToInt32(tokens[0]);
                    type = tokens[1];

                    switch (type)
                    {
                        case "allat":
                            for (int j = 0; j < db; j++)
                            {
                                l = reader.ReadLine(out string line1);
                                string[] tokens1 = line1.Split(separators, StringSplitOptions.RemoveEmptyEntries);

                                IEletkor fajta = null!;
                                if (tokens1[1] == "fiatal") fajta = Fiatal.Instance();
                                if (tokens1[1] == "felnőtt") fajta = Felnott.Instance();

                                if (tokens1[0] == "pinty") k1.Hozzaad(new Pinty(fajta, tokens1[2], tokens1[3], Convert.ToDouble(tokens1[4])));
                                if (tokens1[0] == "tarantulla") k1.Hozzaad(new Tarantulla(fajta, tokens1[2], tokens1[3], Convert.ToDouble(tokens1[4])));
                                if (tokens1[0] == "horcsog") k1.Hozzaad(new Horcsog(fajta, tokens1[2], tokens1[3], Convert.ToDouble(tokens1[4])));
                            }
                            break;
                        case "partner":
                            for (int o = 0; o < db; o++)
                            {
                                l = reader.ReadLine(out string line2);
                                string[] tokens2 = line2.Split(separators, StringSplitOptions.RemoveEmptyEntries);
                                k1.Szerzodes(new Partner(tokens2[0], tokens2[1], k1));

                            }
                            break;
                        case "szamla":
                            for (int u = 0; u < db; u++)
                            {
                                l = reader.ReadLine(out string line3);
                                string[] tokens3 = line3.Split(separators, StringSplitOptions.RemoveEmptyEntries);
                                Partner p = k1.PartnerKereses(tokens3[2]);
                                Allat a = k1.AllatKereses(tokens3[3]);

                                k1.Szamlazas(new Szamla(tokens3[0], k1, p, a, DateTime.Parse(tokens3[4]), tokens3[5]));
                                if (tokens3[0] == "eladasi") k1.Elad(a);
                            }
                            break;
                        default:
                            break;
                    }


                }
                k = k1;
            }



        }
    }
}
