using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PetStore
{
    public abstract class Allat
    {
        public IEletkor kor;
        public string azonosito;
        public string szin;
        public double ertek;
        public Allat(IEletkor kor, string azonosito, string szin, double ertek)
        {
            this.kor = kor;
            this.azonosito = azonosito;
            this.szin = szin;
            this.ertek = ertek;
        }
        public abstract double Ertek(); 
    }

    public class Horcsog : Allat
    {
        private Horcsog horcsog;
        public Horcsog(IEletkor kor, string azonosito, string szin, double ertek) : base(kor, azonosito, szin, ertek)
        {
            this.kor = kor;
            this.azonosito = azonosito;
            this.szin = szin;
            this.ertek = ertek;
        }
        public override double Ertek()
        {
            return kor.Szorzo(horcsog) * ertek;
        }
    }
    public class Pinty : Allat
    {
        private Pinty pinty;
        public Pinty(IEletkor kor, string azonosito, string szin, double ertek) : base(kor, azonosito, szin, ertek)
        {
            this.kor = kor;
            this.azonosito = azonosito;
            this.szin = szin;
            this.ertek = ertek;

        }
        public override double Ertek()
        {
            return kor.Szorzo(pinty) * ertek;
        }
    }
    public class Tarantulla : Allat
    {
        private Tarantulla tarantulla;
        public Tarantulla(IEletkor kor, string azonosito, string szin, double ertek) : base(kor, azonosito, szin, ertek)
        {
            this.kor = kor;
            this.azonosito = azonosito;
            this.szin = szin;
            this.ertek = ertek;

        }
        public override double Ertek()
        {
            return kor.Szorzo(tarantulla) * ertek;
        }

    }
}
