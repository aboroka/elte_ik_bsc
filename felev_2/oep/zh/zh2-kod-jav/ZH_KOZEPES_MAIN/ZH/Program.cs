using System;
using System.Collections.Generic;
using TextFile;
using System.Reflection;
using System.Linq;
using System.Linq.Expressions;
using System.Runtime.InteropServices;
using System.Transactions;
using KOZEPES;

namespace ZH
{
    class Program
    {
        
        static void Main()
        {
            (Varos v, Latvanyossag l, int index) = Read();
            TestDeclare3();
            TestRun3(v, l, index);
        }

        enum Visibility
        {
            Public,
            Protected,
            Private
        }
        static (Varos, Latvanyossag, int) Read()
        {
            // BEOLVASÁS BEÉGETÉS HELYETT
           //Katedralis k = new Katedralis(1, 1, 1, 1);
           // Varos v = new Varos(new List<Negyed> { new Negyed("észak", new List<Latvanyossag> { k, new Muzeum(1, 1, 1, 1) }) });
           // int index = 0;
            

            TextFileReader reader = new("input.txt");

            reader.ReadInt(out int negyedInd);
            reader.ReadInt(out int X);
            reader.ReadInt(out int Y);
 

            Latvanyossag adottLatvanyossag = null;
            List<Negyed> negyedek = new List<Negyed>();
            
            while (reader.ReadString(out string negyednev))
            {
                reader.ReadInt(out int count);
                List<Latvanyossag> latvanyossagok = new List<Latvanyossag>();
                for (int i = 0; i < count; i++)
                {
                    reader.ReadString(out string latvanyossagTipus);
                    reader.ReadInt(out int latvanyossagX);
                    reader.ReadInt(out int latvanyossagY);
                    reader.ReadInt(out int latvanyossagIzg);
                    reader.ReadInt(out int latvanyossagEv);

                    Latvanyossag latvanyossag;
                    switch (latvanyossagTipus)
                    {
                        case "diadaliv":
                            latvanyossag = new Diadaliv(latvanyossagX, latvanyossagY, latvanyossagIzg, latvanyossagEv);
                            break;
                        case "muzeum":
                            latvanyossag = new Muzeum(latvanyossagX, latvanyossagY, latvanyossagIzg, latvanyossagEv);
                            break;
                        case "var":
                            latvanyossag = new Var(latvanyossagX, latvanyossagY, latvanyossagIzg, latvanyossagEv);
                            break;
                        case "katedralis":
                            latvanyossag = new Katedralis(latvanyossagX, latvanyossagY, latvanyossagIzg, latvanyossagEv);
                            break;
                        default:
                            throw new ArgumentException("Érvénytelen látványosság típus a fájlban!");
                    } 
                    if (latvanyossag.KoordX == X && latvanyossag.KoordY == Y)
                        adottLatvanyossag = latvanyossag;
                    
                    latvanyossagok.Add(latvanyossag);
                }
                negyedek.Add(new Negyed(negyednev, latvanyossagok));

            }

            return (new Varos(negyedek), adottLatvanyossag, negyedInd);


        }
        static bool IsFieldsCorrect(Type type, List<(Type, int)> fieldCounts)
        {
            bool isCorrent = true;
            FieldInfo[] fieldInfos = type.GetFields(
                BindingFlags.Instance |
                BindingFlags.Public |
                BindingFlags.NonPublic);

            foreach (var field in fieldCounts)
            {
                int c = fieldInfos.Count(f => f.FieldType == field.Item1);
                isCorrent &= c == field.Item2;
            }
            return isCorrent;
        }
        static void CheckMethodCorrect(Type type, string name, List<(Type, int)> parameterCounts, Type returnType, bool isVirtual, Visibility visibility, Type declaringType, bool isStatic)
        {
            MethodInfo method = type.GetMethod(name,
                BindingFlags.Instance |
                BindingFlags.Public |
                BindingFlags.NonPublic |
                BindingFlags.Static);

            if (method == null)
            {
                Console.WriteLine($"{type.Name}.{name} method is correct: {false}");
                return;
            }

            bool isCorrent = true;
            isCorrent &= method.IsStatic == isStatic;
            isCorrent &= method.DeclaringType == declaringType;
            isCorrent &= method.GetParameters().Length == parameterCounts.Sum(p => p.Item2);
            foreach(var parameter in parameterCounts)
            {
                isCorrent &= method.GetParameters().Count(p => p.ParameterType == parameter.Item1) == parameter.Item2;
            }
            isCorrent &= method.ReturnType == returnType;
            isCorrent &= method.IsVirtual == isVirtual;
            isCorrent &= method.IsPublic == (visibility == Visibility.Public);
            isCorrent &= method.IsPrivate == (visibility == Visibility.Private);
            Console.WriteLine($"{type.Name}.{name} method definition is correct: {isCorrent}");
        }
        static void CheckType(Type type, Type baseType, bool isAbstract, List<(Type, int)> fieldCounts, Type[] constructorTypes)
        {
            bool typeIsDerivedFromBaseType = type.BaseType == baseType;
            Console.WriteLine($"{type.Name} is derived from {baseType.Name}: {typeIsDerivedFromBaseType}");

            bool typeAbstractCorrect = type.IsAbstract == isAbstract;
            Console.WriteLine($"{type.Name} is {(isAbstract ? "" : "not")} abstract: {typeAbstractCorrect}");

            bool typeFieldsCorrect = IsFieldsCorrect(type, fieldCounts);
            Console.WriteLine($"{type.Name} fields are correct: {typeFieldsCorrect}");

            bool typeConstructorCorrect = type.GetConstructor(constructorTypes) != null;
            Console.WriteLine($"{type.Name} constructor is correct: {typeConstructorCorrect}");
        }

        static void TestDeclare3()
        {
            Console.WriteLine("Test3:\n");

            List<(Type, int)> empty = new List<(Type, int)>();
            Type objectType = typeof(object);
            Type[] ints = new Type[] { typeof(int), typeof(int), typeof(int), typeof(int) };

            // Testing Latvanyossag
            Type latvanyossag = typeof(Latvanyossag);
            CheckType(latvanyossag, objectType, true, new List<(Type, int)> { (typeof(int), 4) }, ints);
            CheckMethodCorrect(latvanyossag, "IsKatedralis", empty, typeof(bool), true, Visibility.Public, latvanyossag, false);
            CheckMethodCorrect(latvanyossag, "EltolthetoIdo", empty, typeof(int), false, Visibility.Public, latvanyossag, false);
            CheckMethodCorrect(latvanyossag, "Faktor", empty, typeof(int), true, Visibility.Protected, latvanyossag, false);
            CheckMethodCorrect(latvanyossag, "Tav", new List<(Type, int)> { (typeof(Latvanyossag), 2) }, typeof(int), false, Visibility.Public, latvanyossag, true);
            CheckMethodCorrect(latvanyossag, "Legtavolabb", new List<(Type, int)> { (typeof(List<Latvanyossag>), 1) }, typeof(int), false, Visibility.Public, latvanyossag, false);
            Console.WriteLine();

            // Testing Latvanyossag child classes
            foreach ((Type, bool, int) data in new List<(Type, bool, int)> {(typeof(Diadaliv), false, 40),
                                                                         (typeof(Katedralis), true, 56),
                                                                         (typeof(Var), false, 92),
                                                                         (typeof(Muzeum), false, 2222)})
            {
                Type type = data.Item1;

                CheckType(type, latvanyossag, false, empty, ints);

                ConstructorInfo constructor = type.GetConstructor(new Type[] { typeof(int), typeof(int), typeof(int), typeof(int) });

                CheckMethodCorrect(type, "IsKatedralis", empty, typeof(bool), true, Visibility.Public, data.Item2 ? type : latvanyossag, false);
                CheckMethodCorrect(type, "EltolthetoIdo", empty, typeof(int), false, Visibility.Public, latvanyossag, false);
                CheckMethodCorrect(type, "Faktor", empty, typeof(int), true, Visibility.Protected, type, false);

                bool typeMethodBehaviorCorrect;
                try
                {
                    Latvanyossag instance = (Latvanyossag)constructor.Invoke(new object[] { 2, 2, 2, 2000 });
                    typeMethodBehaviorCorrect = instance.IsKatedralis() == data.Item2;
                    typeMethodBehaviorCorrect &= instance.EltolthetoIdo() == data.Item3;
                }
                catch
                {
                    typeMethodBehaviorCorrect = false;
                }
                Console.WriteLine($"{type.Name} method behaviors are correct: {typeMethodBehaviorCorrect}");
                Console.WriteLine();
            }

            Type NegyedList = typeof(List<Negyed>);
            Type LatvanyossagList = typeof(List<Latvanyossag>);

            Type varos = typeof(Varos);
            CheckType(varos, objectType, false, new List<(Type, int)>{(NegyedList, 1)}, new Type[] { NegyedList });
            CheckMethodCorrect(varos, "MelyikNegyed", new List<(Type, int)> { (typeof(Latvanyossag), 1) }, typeof(Negyed), false, Visibility.Public, varos, false);
            Console.WriteLine();

            Type negyed = typeof(Negyed);
            CheckType(negyed, objectType, false, new List<(Type, int)> { (typeof(string), 1), (LatvanyossagList, 1) }, new Type[] { typeof(string), LatvanyossagList });
            CheckMethodCorrect(negyed, "MaxTav", empty, typeof(int), false, Visibility.Public, negyed, false);
            Console.WriteLine();
        }

        static void TestRun3(Varos v, Latvanyossag l, int index)
        {
            Console.WriteLine($"{index + 1}. Negyed.MaxTav: {v.negyedek[index].MaxTav()}");
            Console.WriteLine($"Varos.MelyikNegyed: {v.MelyikNegyed(l).nev}");
            Console.WriteLine();
        }

        
    }
}