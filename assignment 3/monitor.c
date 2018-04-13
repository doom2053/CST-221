 #include <unistd.h>
#include <stdlib.h>
#include <stdio.h>


 monitor ProducerConsumer
    condition full, empty;
    int count;
  
  procedure enter();
  {
    if (count == N) wait(full);        // if buffer is full, block
    put_item(widget);                  // put item in buffer
    count = count + 1;                 // increment count of full slots
    if (count == 1)  signal(empty);    // if buffer was empty, wake consumer
  }

  procedure remove();
  {
    if (count == 0)  wait(empty);      // if buffer is empty, block
    remove_item(widget);               // remove item from buffer
    count = count - 1;                 // decrement count of full slots
    if (count == N-1)  signal(full);   // if buffer was full, wake producer
  }

  count = 0;
  end monitor;

  Producer();
  {
    while (TRUE)
   {
      make_item(widget);               // make a new item
      ProducerConsumer.enter;          // call enter function in monitor
   }
  }

  Consumer();
  {
    while (TRUE)
    {
      ProducerConsumer.remove;         // call remove function in monitor
      consume_item;                    // consume an item
   }
  }