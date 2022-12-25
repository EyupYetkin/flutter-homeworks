import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Main {
    public static void main(String[] args) {
        MyStack stack1 = new MyStack();
        MyStack stack2 = new MyStack();


        String cumle;
        Scanner sc = new Scanner(System.in);
        System.out.println("String gir.");
        cumle = sc.next();


        final String regex = "\\p{Lu}\\p{Ll}*|\\p{L}+|\\d+|[^\\p{L}\\d]+";
        final Pattern pattern = Pattern.compile(regex, Pattern.UNICODE_CHARACTER_CLASS);
        final Matcher matcher = pattern.matcher(cumle);
        List<String> matchesList = new ArrayList<>();
        while (matcher.find()) {
            matchesList.add(matcher.group());
        }
        int sizeOfNewArray = matchesList.size();
        String[] newArrayOfMatches = new String[sizeOfNewArray];
        matchesList.toArray(newArrayOfMatches);


        for (String c: matchesList) {
            boolean numeric = true;
            int num = 0;
            try {
                num = Integer.parseInt(c);
            } catch (NumberFormatException e) {
                numeric = false;
            }

            if(numeric){
                if(stack2.bosMu()){
                    Pair gecici = stack1.cikar();
                    gecici.key=gecici.key*num;
                    stack1.ekle(gecici);
                }
                else {
                    while (!stack2.bosMu()){
                        Pair temp = stack2.cikar();
                        temp.key= temp.key*num;
                        stack1.ekle(temp);
                    }
                }
            }

            else {
                if (Objects.equals(c, ")")){
                    while(!Objects.equals(stack1.tepe().value, "(")){
                        stack2.ekle(stack1.cikar());
                    }
                    stack1.cikar();
                }
                else {
                    stack1.ekle(new Pair(c));
                }
            }
        }



        if(stack1.bosMu()){
            while (!stack2.bosMu()){
                stack1.ekle(stack2.cikar());
            }
        }


        stack1.listele();
    }
}