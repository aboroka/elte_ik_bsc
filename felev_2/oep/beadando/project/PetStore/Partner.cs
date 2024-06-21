using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PetStore
{
    public class Partner
    {
        public string tipus;
        public string azon;
        public Allatkereskedes kereskedes;
        public List<Szamla> szamlak;
        public Partner(string tipus, string azon, Allatkereskedes kereskedes)
        {
            this.tipus = tipus;
            this.azon = azon;
            this.kereskedes = kereskedes;
            szamlak = new List<Szamla>();
        }
        public void Szamlazas(Szamla szamla)
        {
            szamlak.Add(szamla);
        }
    }
}
