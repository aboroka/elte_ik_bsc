using PetStore;
using System.Net.Http.Headers;

namespace TestProject1
{
    [TestClass]
    public class PetStoreTest
    {
        [TestMethod]
        public void AllatKeszitesTest()
        {
            Allatkereskedes k1 = new Allatkereskedes();

            Allat a1 = new Horcsog(Fiatal.Instance(), "01", "piros", 1000);

            Assert.IsInstanceOfType(a1.kor, typeof(Fiatal));
            Assert.AreEqual("01",a1.azonosito);
            Assert.AreEqual("piros", a1.szin);
            Assert.AreEqual(1000, a1.ertek);

        }
        [TestMethod]
        public void SzerzodesTest()
        {
            Allatkereskedes k1 = new Allatkereskedes();
            Partner p1 = new Partner("beszerzo", "p1", k1);
            k1.Szerzodes(p1);
            Assert.AreEqual(p1, k1.partnerek[0]);
        }
        [TestMethod]
        public void PartnerKeresesTest()
        {
            Allatkereskedes k1 = new Allatkereskedes();
            Partner p1 = new Partner("beszerzo", "p1", k1);

            k1.Szerzodes(p1);

            Assert.AreEqual(p1, k1.PartnerKereses("p1"));
        }
        [TestMethod]
        public void AllatKeresesTest()
        {
            Allatkereskedes k1 = new Allatkereskedes();
            Allat a1 = new Pinty(Fiatal.Instance(), "01", "barna", 1000);


            k1.Hozzaad(a1);

            Assert.AreEqual(a1, k1.AllatKereses("01"));
        }
        [TestMethod]
        public void AdottSzinPintyTest()
        {
            Allatkereskedes k1 = new Allatkereskedes();

            Allat a1 = new Pinty(Fiatal.Instance(), "01", "barna", 1000);

            k1.Hozzaad(a1);

            Assert.IsTrue(k1.AdottSzinPinty("barna"));
        }
        [TestMethod]
        public void HanyHorcsogTest()
        {
            Allatkereskedes k1 = new Allatkereskedes();

            Allat a1 = new Horcsog(Fiatal.Instance(), "01", "piros", 1000);
            k1.Hozzaad(a1);


            Assert.AreEqual(1, k1.HanyHorcsog());
        }
        [TestMethod]
        public void LegnagyobbEszmeiErtekuTarantullaTest()
        {
            Allatkereskedes k1 = new Allatkereskedes();

            Allat a1 = new Tarantulla(Fiatal.Instance(), "01", "fekete", 2000);
            Allat a2 = new Tarantulla(Felnott.Instance(), "02", "fekete", 1000);
            k1.Hozzaad(a1);
            k1.Hozzaad(a2);
            Assert.AreEqual("01", k1.LegnagyobbEszmeiErtekuTarantulla());
        }
        [TestMethod]
        public void HanySzerzodesAdottPartnerrelTest()
        {
            Allatkereskedes k1 = new Allatkereskedes();
            Partner p1 = new Partner("beszerzo", "p1", k1);
            Partner p2 = new Partner("beszerzo", "p2", k1);

            k1.Szerzodes(p1);
            k1.Szerzodes(p2);

            Assert.AreEqual(1, k1.HanySzerzodesAdottPartnerrel("p1"));

        }
        [TestMethod]
        public void NyeresegTest()
        {
            Allatkereskedes k1 = new Allatkereskedes();
            Allat a1 = new Tarantulla(Fiatal.Instance(), "01", "fekete", 2000);
            Partner p1 = new Partner("elado", "p1", k1);
            Szamla sz1 = new Szamla("eladasi", k1, p1, a1, DateTime.Now, "sz1");

            k1.Szerzodes(p1);
            k1.Hozzaad(a1);
            k1.Szamlazas(sz1);

            Assert.AreEqual(6000, k1.Nyereseg());
        }
        [TestMethod]
        public void InputTest()
        {
            Allatkereskedes k1 = new Allatkereskedes();
            Allat a1 = new Horcsog(Fiatal.Instance(), "01", "piros", 1000);
            Allat a2 = new Pinty(Felnott.Instance(), "02", "Sárga", 1500);
            Allat a3 = new Tarantulla(Fiatal.Instance(), "03", "fekete", 2300);
            Allat a4 = new Pinty(Fiatal.Instance(), "04", "barna", 1600);
            k1.Hozzaad(a1);
            k1.Hozzaad(a2);
            k1.Hozzaad(a3);
            k1.Hozzaad(a4);
            Partner p1 = new Partner("beszerzo", "p1", k1);
            Partner p2 = new Partner("elado", "p2", k1);
            k1.Szerzodes(p1);
            k1.Szerzodes(p2);
            Szamla sz1 = new Szamla("beszerzesi", k1, p1, a1, DateTime.Now, "sz1");
            Szamla sz2 = new Szamla("eladasi", k1, p2, a2, DateTime.Now, "sz2");
            k1.Szamlazas(sz1);
            k1.Szamlazas(sz2);
            k1.Elad(a2);

            Assert.AreEqual(3, k1.allatok.Count);
            Assert.AreEqual(2, k1.szamlak.Count);
            Assert.AreEqual(2, k1.partnerek.Count);

            Assert.IsTrue(k1.AdottSzinPinty("barna"));
            Assert.AreEqual(1, k1.HanyHorcsog());
            Assert.AreEqual("03", k1.LegnagyobbEszmeiErtekuTarantulla());
            Assert.AreEqual(1, k1.HanySzerzodesAdottPartnerrel("p1"));
            Assert.AreEqual(2500, k1.Nyereseg());


        }
        [TestMethod]
        public void ErtekTest()
        {
            Allatkereskedes k1 = new Allatkereskedes();
            Allat a1 = new Horcsog(Fiatal.Instance(), "01", "piros", 1000);
            Assert.AreEqual(2000, a1.Ertek());
        }
        [TestMethod]
        public void PartnerSzamlazasTest()
        {
            Allatkereskedes k1 = new Allatkereskedes();
            Allat a1 = new Horcsog(Fiatal.Instance(), "01", "piros", 1000);
            Partner p1 = new Partner("beszerzo", "p1", k1);
            Szamla sz1 = new Szamla("beszerzesi", k1, p1, a1, DateTime.Now, "sz1");
            p1.Szamlazas(sz1);
            Assert.AreEqual(1, p1.szamlak.Count);
        }
        [TestMethod]
        public void ExcpetionTest()
        {
            Allatkereskedes k1 = new Allatkereskedes();
            Allat a1 = new Horcsog(Fiatal.Instance(), "01", "piros", 1000);
            Assert.ThrowsException<NoAnimalException>(()=>k1.Elad(a1));
        }
    }
}