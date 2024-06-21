using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PetStore
{
    public interface IEletkor
    {
        public double Szorzo(Horcsog horcsog);
        public double Szorzo(Pinty pinty);
        public double Szorzo(Tarantulla tarantulla);
    }
    public class Fiatal : IEletkor
    {
        private static Fiatal instance;
        private Fiatal() { }
        public static Fiatal Instance()
        {
            instance ??= new Fiatal();
            return instance;
        }
        public double Szorzo(Horcsog horcsog) { return 2.0; }
        public double Szorzo(Pinty pinty) { return 1.0; }
        public double Szorzo(Tarantulla tarantulla) { return 3.0; }
    }
    public class Felnott : IEletkor
    {
        private static Felnott instance;
        private Felnott() { }
        public static Felnott Instance()
        {
            instance ??= new Felnott();
            return instance;
        }
        public double Szorzo(Horcsog horcsog) { return 1.0; }
        public double Szorzo(Pinty pinty) { return 3.0; }
        public double Szorzo(Tarantulla tarantulla) { return 2.0; }
    }
}
