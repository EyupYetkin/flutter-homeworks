#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Müsteri bilgisi yapisi
typedef struct {
    int musteri_no;
    char ad[20], soyad[20];
} Musteri;

// Hash tablo boyutu
#define TABLO_BOYUTU 10

// Hash tablo dizisi
Musteri *veri_liste[TABLO_BOYUTU];

// Müsteri numaraları icin Hash tablosu
int hash_tablo[TABLO_BOYUTU];

// Hash fonksiyonlari
int h1(int n) {
    return (3 * n + 2) % TABLO_BOYUTU;
}

int h2(int n) {
    return (7 * n + 2) % TABLO_BOYUTU;
}


// Hash tablosuna Musteri eklemek icin fonksiyon
int doluMu=0;
int musteriEkle(int musteri_no, char* ad, char* soyad) {
    if (doluMu==TABLO_BOYUTU){
        printf("Tablo dolu ekleme yapilamaz.\n");
        return -1;
    }

    // h1 fonksiyon kullanilarak index belirlenir
    int index = (h1(musteri_no) % TABLO_BOYUTU);

    // Veri eklenirken collusion olusursa buraya girer
    int i = 1;
    while (hash_tablo[index] != -1) {
        // Bos olup olmadigi kontrol edilecek diger index icin h2 fonksiyonu kullanilir
        index = (h1(musteri_no) + i * h2(musteri_no)) % TABLO_BOYUTU;
        i++;
        if (h2(musteri_no) % TABLO_BOYUTU == 0) {
            while (hash_tablo[index] != -1) {
                index++;
                index = index % TABLO_BOYUTU;
            }
        }
    }

    // Yeni musteri bilgisi icin malloc ile hafiza ayrilir
    Musteri* musteri = (Musteri*) malloc(sizeof(Musteri));
    musteri->musteri_no = musteri_no;
    strcpy(musteri->ad, ad);
    strcpy(musteri->soyad, soyad);

    // Hash_tablo ve veri_listeye veriler eklenir
    veri_liste[index] = musteri;
    hash_tablo[index] = musteri_no;
    doluMu=doluMu+1;
}

// Hash tablosundan arama yapmak icin fonksiyon
Musteri* arama(int musteri_no) {
    // h1 fonksiyonu kullanilarak index belirlenir
    int index = (h1(musteri_no) % TABLO_BOYUTU);
    int i = 1;
    // Musteri numarasina ulasincaya kadar calisan while
    while (hash_tablo[index] != musteri_no) {
        i++;
        if(i == 10){
            break;
        }
        // h2 fonksiyonu ile denenecek diğer index belirlenir
        index = (h1(musteri_no) + i * h2(musteri_no)) % TABLO_BOYUTU;
    }
    // Musteri numarasi bulunursa musteri bilgisi pointeri dondurur
    if (hash_tablo[index] == musteri_no) {
        printf("Veri %d adimda bulundu \n",i);
        return veri_liste[index];
    }
        // Else ile null dondurur
    else {
        return NULL;
    }
}

// Musteri listesini yazdirma fonksiyonu
void musteriListe() {
    printf("Musteri Listesi:\n");
    for (int i = 0; i < TABLO_BOYUTU; i++) {
        // Indexte musteri bilgisi var mi kontrol eder
        if (veri_liste[i] != NULL) {
            // Musteri bilgilerini yazdir
            printf("%d ", veri_liste[i]->musteri_no);
            printf("%s %s", veri_liste[i]->ad, veri_liste[i]->soyad);
            printf("\n");
        } else printf("NULL\n");
    }
}

// Boş olmayan kayıtlara ortalama ulaşma adımını hesaplar
void ortalamaAdimYazdir() {
    int toplam_adim = 0;
    int sayilan_kayit = 0;
    for (int i = 0; i < TABLO_BOYUTU; i++) {
        if (hash_tablo[i] != -1) {
            toplam_adim += i;
            sayilan_kayit++;
        }
    }
    float ortalama_adim = (float) toplam_adim / sayilan_kayit;
    printf("Toplam adim: %d\n", toplam_adim);
    printf("Sayılan Kayıt: %d\n", sayilan_kayit);
    printf("Ortalama Adim: %.2f\n", ortalama_adim);
}

int main() {
    // Hash tablosundaki tüm verileri -1 yapar
    for (int i = 0; i < TABLO_BOYUTU; i++) {
        hash_tablo[i] = -1;
    }

    // Musteri bilgisini "veri.txt" dosyasindan okur, musteriEkle fonksiyonuna gonderir
    FILE *file = fopen("/Users/eyupyetkin/CLionProjects/untitled7/veri.txt", "r");
    int musteri_no;
    char ad[20], soyad[20];
    while (fscanf(file, "%d %s %s", &musteri_no, ad, soyad) == 3) {
        musteriEkle(musteri_no, ad, soyad);
    }
    fclose(file);

    while (1 == 1) {
        int islem;
        printf("\n");
        printf("Ekleme İslemi: 1\n");
        printf("Arama İslemi: 2\n");
        printf("Listeleme İslemi: 3\n");
        printf("Ortalama Adim Sayisi: 4\n");
        printf("Cikmak icin: 0\n");
        printf("Secimini gir: ");
        scanf(" %d", &islem);
        printf("\n");
        switch (islem) {
            case 1:
                //Kullanicidan gelen veriler ile ekleme yapmayi sağlar
                printf("Eklenecek Musteri Bilgileri:\n");
                printf("Musteri Numarasi giriniz:\n"); int e_mus_nu; scanf("%d",&e_mus_nu);
                printf("Adi giriniz:\n");char e_mus_adi[20];scanf("%s",e_mus_adi);
                printf("Soyadi giriniz:\n");char e_mus_soyadi[20];scanf("%s",e_mus_soyadi);
                musteriEkle(e_mus_nu, e_mus_adi, e_mus_soyadi);
                break;
            case 2:
                // Aranacak musteri numarasini kullanicidan ister
                printf("Aranacak musteri numarasini giriniz: ");
                int aranacak_num;
                scanf("%d", &aranacak_num);
                // Arama fonksiyonuna aranacak_num fonksiyonuna gonderir
                Musteri *musteri = arama(aranacak_num);
                // Aranan bilgisi icin varsa yoksa
                if (musteri != NULL) {
                    printf("%d %s %s\n", musteri->musteri_no, musteri->ad, musteri->soyad);
                } else {
                    printf("Musteri bulunamadi.\n");
                }
                break;
            case 3:
                // Musteri listesini yazdirir
                musteriListe();
                break;
            case 4:
                // Boş olmayan kayıtlara ortalama ulaşma adımını hesaplar
                ortalamaAdimYazdir();
                break;
            case 0:
                exit(0);
            default:
                printf("Gecersiz giris. Tekrar dene. \n");
        }
    }
}
