import java.util.Scanner;
public class Main {
    public static void main(String[] args) {
        /*


         */
        Scanner girdi = new Scanner(System.in);
        System.out.println("Sifrelenmesini istediginiz metni giriniz..");
        String mesaj = girdi.next();
        girdi.close();
        System.out.println("\n");
        rsaSifreleme rsa = new rsaSifreleme(mesaj);
        rsa.anahtarOlustur();
        System.out.println("Sifrelenmis metin:");
        System.out.println(rsa.metinSifrele());
        System.out.println("Cozulmus metin:");
        System.out.println(rsa.metinCoz());


/*



         */

    }

}