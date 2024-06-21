using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PetStore
{
    public class Szamla
    {
        public string tipus;
        public Allatkereskedes kereskedes;
        public Partner partner;
        public Allat allat;
        public DateTime datum;
        public double ar;
        public string azon;

        public Szamla(string tipus, Allatkereskedes kereskedes, Partner partner, Allat allat, DateTime datum, string azon)
        {
            this.tipus = tipus;
            this.kereskedes = kereskedes;
            this.partner = partner;
            this.allat = allat;
            this.datum = datum;
            ar = allat.Ertek();
            this.azon = azon;
        }
        
    }

   
}
