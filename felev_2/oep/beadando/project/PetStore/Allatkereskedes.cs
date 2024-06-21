using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Reflection.Metadata;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace PetStore
{
    public class NoAnimalException : Exception { }
    public class Allatkereskedes
    {
        public List<Partner> partnerek;
        public List<Allat> allatok;
        public List<Szamla> szamlak;
        public Allapot allapot;

        public Allatkereskedes()
        {
            partnerek = new List<Partner>();
            allatok = new List<Allat>();
            szamlak = new List<Szamla>();
            allapot = Allapot.Ures;

        }
        public enum Allapot
        {
            Ures,
            NemUres
        }

        public void Szerzodes(Partner partner)
        {
            partnerek.Add(partner);
        }
        public void Hozzaad(Allat allat)
        {
            allatok.Add(allat);
            NemUres();
        }
        public void Szamlazas(Szamla szamla)
        {
            szamlak.Add(szamla);
        }
        public void Elad(Allat allat)
        {
            if (allatok.Contains(allat))
            {
                allatok.Remove(allat);
                Ures();
            }
            else
            {
                throw new NoAnimalException();
            }
        }

        public Partner PartnerKereses(string azon)
        {
            foreach (var e in partnerek)
            {
                if (e.azon == azon)
                {
                    return e;
                }

            }
            return new Partner("a", "a", this);

        }
        public Allat AllatKereses(string azon)
        {
            foreach (var e in allatok)
            {
                if (e.azonosito == azon)
                {
                    return e;
                }
            }
            return new Horcsog(Fiatal.Instance(), "a", "a", 0);

        }

        public bool AdottSzinPinty(string szin)
        {
            foreach (var e in allatok)
            {
                if (szin == e.szin && e is Pinty)
                {
                    return true;
                }
            }
            return false;
        }

        public int HanyHorcsog()
        {
            int c = 0;
            foreach (var e in allatok)
            {
                if (e is Horcsog)
                {
                    c++;
                }
            }
            return c;
        }

        public string LegnagyobbEszmeiErtekuTarantulla()
        {
            double max = -1;
            string azon = "";
            foreach (var e in allatok)
            {
                if (max < e.Ertek() && e is Tarantulla)
                {
                    max = e.Ertek();
                    azon = e.azonosito;
                }
            }
            return azon;
        }

        public int HanySzerzodesAdottPartnerrel(string azon)
        {
            int c = 0;
            foreach (var e in partnerek)
            {
                if (azon == e.azon)
                {
                    c++;
                }
            }

            return c;
        }

        public double Nyereseg()
        {
            double osszeg = 0;
            foreach (var e in szamlak)
            {
                if (e.tipus == "eladasi")
                {
                    osszeg += e.ar;
                }
                else if (e.tipus == "beszerzesi")
                {
                    osszeg -= e.ar;
                }
            }
            return osszeg;
        }
        public void Ures()
        {
            if (allatok.Count == 0)
            {
                allapot = Allapot.Ures;
            }

        }
        public void NemUres()
        {
            allapot = Allapot.NemUres;
        }


    }
}
