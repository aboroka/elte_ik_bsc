using System.Globalization;

namespace PetStore
{
    internal class Program
    {
        static void Main(string[] args)
        {
            InFile file = new InFile("input.txt");
            Allatkereskedes k1;
            file.Read(out k1);

            // a.
            string adottSzin = "barna";
            if (k1.AdottSzinPinty(adottSzin))
            {
                Console.WriteLine($"Van {adottSzin} színű pinty a kereskedésben");
            }
            else
            {
                Console.WriteLine($"Nincs {adottSzin} színű pinty a kereskedésben");
            }
            // b.
            Console.WriteLine($"Hörcsögök száma a kereskedésben: {k1.HanyHorcsog()}");

            // c.
            Console.WriteLine($"A legnagyobb eszmei értékű tarantula: {k1.LegnagyobbEszmeiErtekuTarantulla()}");

            // d.
            string adottPartner = "p1";
            Console.WriteLine($"A kereskedésnek a(z) {adottPartner} partnerrel {k1.HanySzerzodesAdottPartnerrel(adottPartner)} szerződése van");

            // e.
            Console.WriteLine($"A kereskedés nyeresége: {k1.Nyereseg()}");

            Console.WriteLine(k1.allapot);

          

        }
    }
}