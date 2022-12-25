#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Liste {
    char  *yemek_adi;
    int   yemek_gramaj;
    float yemek_fiyat;
    struct Liste *sonraki;
}BListe;

void bastir(BListe *r){
    BListe *iter = r;
    printf("%s, %dgr, %.2f TL\n",iter->yemek_adi, iter->yemek_gramaj, iter->yemek_fiyat);
    iter = iter -> sonraki;
    while (iter != r){
        printf("%s, %d, %.2f TL\n", iter->yemek_adi, iter->yemek_gramaj, iter->yemek_fiyat);
        iter = iter -> sonraki;
    }
    printf("\n");
}

BListe *ekleSirali(BListe *r, char *yemek_adi, int yemek_gramaj, float yemek_fiyat){
    if (r==NULL){
        r =(BListe*)malloc(sizeof (BListe));
        r->sonraki=r;
        r->yemek_adi = strdup(yemek_adi);
        r->yemek_gramaj=yemek_gramaj;
        r->yemek_fiyat=yemek_fiyat;
        return r;
    }

    if (r->yemek_fiyat > yemek_fiyat){
        BListe * gecici = (BListe *) malloc(sizeof(BListe));
        gecici->yemek_adi=strdup(yemek_adi);
        gecici->yemek_gramaj=yemek_gramaj;
        gecici->yemek_fiyat=yemek_fiyat;
        gecici->sonraki=r;
        BListe * iter=r;
        while (iter->sonraki!=r) {
            iter=iter->sonraki;
        }
        iter->sonraki=gecici;
        return  gecici;
    }

    BListe * iter=r;
    while(iter->sonraki != r && iter->sonraki->yemek_fiyat < yemek_fiyat){
        iter= iter->sonraki;
    }

    BListe * gecici = (BListe*) malloc(sizeof(BListe));

    gecici->sonraki=iter->sonraki;
    iter->sonraki=gecici;
    gecici->yemek_adi= strdup(yemek_adi);
    gecici->yemek_gramaj=yemek_gramaj;
    gecici->yemek_fiyat=yemek_fiyat;

    return r;
};


BListe *deserialize(BListe *r){
    BListe *root=r;
    FILE *file = fopen("list.txt", "r");
    if (file == NULL){
        printf("Text dosyası yok.");
        exit(2);
    }
    char  desyemekadi[20]; int   desyemekgramaj; float desyemekfiyat;
    while (fscanf(file,"%s %d %f", desyemekadi, &desyemekgramaj, &desyemekfiyat) > 0){
        root=ekleSirali(root, desyemekadi, desyemekgramaj, desyemekfiyat);
    }
    fclose(file);
    return root;
}

BListe *sil(BListe *r){
    BListe *gecici;
    BListe *iter = r;
    char silinecekYemek[30];
    printf("Silinecek yemek?\n");
    scanf("%s", silinecekYemek);

    if(strcmp(r->yemek_adi, silinecekYemek)==0){
        while(iter->sonraki!=r){
            iter=iter->sonraki;
        }
        iter->sonraki=r->sonraki;
        free(r);
        return iter->sonraki;
    }

    while (iter->sonraki != r){
        if (strcmp(iter->sonraki->yemek_adi, silinecekYemek)==0){
            break;
        }
        iter = iter->sonraki;
    }

    if(iter->sonraki== r){
        printf("Yemek bulunamadi!\n\n");
        return r;
    }

    gecici = iter->sonraki;
    iter->sonraki = iter->sonraki->sonraki;
    free(gecici);
    return r;
}

void yemekSecim(BListe *r){
    BListe *iter = r;
    char a;
    int run = 1;
    printf("\n'e': Yemek secimi icin \n"
           "'h': Bir sonraki yemege gecmek icin \n"
           "'a': Ana menuye donmek icin \n\n");
    while(run==1){
        printf("%s %dgr %.2fTL (e/h/a): ",iter->yemek_adi, iter->yemek_gramaj, iter->yemek_fiyat);
        scanf(" %c",&a);
        switch (a) {
            case 'E':
            case 'e':
                printf(" %s Sectiniz.\n Siparisiniz en kisa zamanda teslim edilecektir.\n Afiyet olsun.",iter->yemek_adi);
                exit(0);
            case 'H':
            case 'h':
                iter = iter -> sonraki;
                break;
            case 'A':
            case 'a':
                run =0;
                break;
            default:
                printf("Gecersiz giris");
                break;
        }
    }
}

int main() {
    BListe *root;
    root = NULL;
    root=deserialize(root);
    char secim;
    while(1==1){
        printf("\n'E'kleme, 'S'ilme, 'L'isteleme, 'Y'emek Secimi ve 'C'ıkış: ");
        scanf(" %c", &secim);
        switch (secim) {
            case 'E':
            case 'e':
                printf("Yemek Bilgileri\n");
                printf("Yemek adi giriniz:\n");char yemekadi[20];scanf("%s",yemekadi);
                printf("Yemek gramaj giriniz:\n"); int yemekgramaj; scanf("%d",&yemekgramaj);
                printf("Yemek fiyat gir\n"); float yemekfiyat; scanf("%f",&yemekfiyat);
                printf("\n");
                root=ekleSirali(root,yemekadi,yemekgramaj,yemekfiyat);
                bastir(root);
                break;

            case 'L':
            case 'l':
                bastir(root);
                break;
            case 'S':
            case 's':
                root=sil(root);
                bastir(root);
                break;
            case 'Y':
            case 'y':
                yemekSecim(root);
                break;
            case 'C':
            case 'c':
                exit(0);
            default:
                printf("Gecersiz giris. Tekrar dene. \n");
        }
    }
}

