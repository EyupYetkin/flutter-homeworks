def kombinasyonlar(numara_karakterleri, numara, index, son_kombinasyon):

    if index == len(numara):
        print(son_kombinasyon)
        return

    for harf in numara_karakterleri[numara[index]]:

        kombinasyonlar(numara_karakterleri, numara, index + 1, son_kombinasyon + harf)

numara_karakterleri = {
    '1': [''],
    '2': ['a', 'b', 'c'],
    '3': ['d', 'e', 'f'],
    '4': ['g', 'h', 'i'],
    '5': ['j', 'k', 'l'],
    '6': ['m', 'n', 'o'],
    '7': ['p', 'q', 'r', 's'],
    '8': ['t', 'u', 'v'],
    '9': ['w', 'x', 'y', 'z'],
    '0': ['']
}

while(1==1):
    print("Harf kombinasyonları bulmak istediğiniz sayıyı giriniz.")
    print("Çıkmak için q kullan.")

    sayi = input("Sayıyı gir: ")
    if (sayi=='q'):
        break
    kombinasyonlar(numara_karakterleri, sayi, 0, '')
    print('\n')



