//Program for RSA asymmetric cryptographic algorithm
//for demonstration values are relatively small compared to practical application

#include<stdio.h>
#include<math.h>

int gcd(int a, int h)
{
    int temp;
    while(1)
    {
        temp = a%h;
        if(temp==0)
        return h;
        a = h;
        h = temp;
    }
}

void rsa(double msg){

    double p, q, n, count, totient;
    double e, d, k, c, m;

    p = 3;
    q = 7;
    n = p*q;
    totient = (p - 1)*(q - 1);
    e = 2;
    k = 2;

    //for checking co-prime which satisfies e>1
    while(e < totient){
        count = gcd(e, totient);
    if(count == 1)
        break;
    else
        e++;
    }

    //choosing d such that it satisfies d*e = 1 + k * totient
    d = (1 + (k*totient))/e;
    c = pow(msg, e);
    m = pow(c, d);
    c = fmod(c, n);
    m = fmod(m, n);
    /*
    printf("Message data = %lf",msg);
    printf("\np = %lf",p);
    printf("\nq = %lf",q);
    printf("\nn = pq = %lf",n);
    printf("\ntotient = %lf",totient);
    printf("\ne = %lf",e);
    printf("\nd = %lf",d);
    printf("\nEncrypted data = %lf",c);
    printf("\nOriginal Message Sent = %lf\n",m);
    */
}

int main()
{
    rsa(1325321.0);
    rsa(2561321.0);
    rsa(6216818.0);
    rsa(9846854.0);
    rsa(4846518.0);
    rsa(3549818.0);

    return 0;
}
