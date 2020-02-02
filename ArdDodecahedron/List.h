class List {
  
    public:
        int item[240];
        int len;
        List();
        void append(int i){
            item[size()]=i;
        }
        void print(){
            //Serial.print("\n\nNieuwe Print:\n");
            //Serial.println(this->size());
            for(int i=0;i<30;i++){
                //Serial.print(item[i]);Serial.print(" ");
                if(i%30 == 29){
                    //Serial.print("\n");
                }
            }
        }
        void shift(int counter) {//shifts items in index to the left to keep size locked.
            for(int i = 0; i<counter;i++){
                item[i] = item[i+1];
            }
            item[counter] = -1;
            
        }
        int size(){//look for values that != -1 to determine size of chaser.
            int a=0;
            
            for(int i=0;i<240;i++){
                if(item[i]!=-1)
                    a++;
            }
            return a;
        }
        void setLenght(int len){
            this->len = len;
        }
};

List::List(){//fill array with -1
    for(int i=0;i<240;i++){
        item[i] = -1;
    }
}


