public class MyStack {

    static final int MAX = 1000;
    int indis;
    Pair[] a = new Pair[MAX];

    boolean bosMu()
    {
        return (indis < 0);
    }

    MyStack()
    {
        indis = -1;
    }

    void ekle(Pair x)
    {
        if (indis >= (MAX - 1)) {
            System.out.println("Stack dolu.");
            //return false;
        }
        else {
            a[++indis] = x;
            //return true;
        }
    }

    Pair cikar()
    {
        if (indis < 0) {
            System.out.println("Stack boş.");
            return null;
        }
        else {
            return a[indis--];
        }
    }

    Pair tepe()
    {
        if (indis < 0) {
            System.out.println("Stack boş.");
            return null;
        }
        else {
            return a[indis];
        }
    }

    void listele(){
        for(int i = indis;i>-1;i--){
            System.out.println(a[i].value+":"+a[i].key);
        }
    }
}
