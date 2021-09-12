package es.uned.lsi.eped.pract2020_2021;

import es.uned.lsi.eped.DataStructures.Collection;
import es.uned.lsi.eped.DataStructures.IteratorIF;
import es.uned.lsi.eped.DataStructures.List;
import es.uned.lsi.eped.DataStructures.ListIF;


/*Representa una cola con prioridad implementada mediante una secuencia de SamePriorityQueue*/
public class BucketQueue<E> extends Collection<E> implements PriorityQueueIF<E> {
 
  //LA DEFINICIÓN DE LOS ATRIBUTOS DE LA CLASE ES TAREA DE CADA ESTUDIANTE
	private ListIF <SamePriorityQueue<E>> miLista;
	private SamePriorityQueue<E> cola;
	private IteratorIF <SamePriorityQueue<E>> lista;
	

  /* Clase privada que implementa un iterador para la *
   * cola con prioridad basada en secuencia.          */
  public class PriorityQueueIterator implements IteratorIF<E> {

    //LA DEFINICIÓN DE LOS ATRIBUTOS DE LA CLASE ES TAREA DE CADA ESTUDIANTE
	  private SamePriorityQueue<E> miCola;
	  private IteratorIF<E> miColaIterator;
	  
	  
      
    /*Constructor por defecto*/
    protected PriorityQueueIterator(){
    	super();
    	lista = miLista.iterator();
    	//Solo si la lista tiene siguiente elemento se crea una cola y su iterator
    	if(lista.hasNext()) {
    		this.miCola = lista.getNext();
    	    this.miColaIterator = this.miCola.iterator();
    	    this.miColaIterator.reset();

    	}
    	
    }
    /*Devuelve el siguiente elemento de la iteración*/
    public E getNext() { 
    	//Si la cola en la que me encuentro tiene siguiente elemento devuelvo true
    	if(miColaIterator.hasNext()){
    			return miColaIterator.getNext();
    		}else {
    			//Si la lista tiene siguiente elemento la obtengo, cola, le hago reset para asegurarme que 
    			//esta en la priemra posicion y devuelvo su primer paciente. 
    			if(lista.hasNext()) {
    				this.miCola = lista.getNext();
    			
    			miColaIterator.reset();
    		return miColaIterator.getNext();
    			}
    	}
    	return null;
    }
    
    /*Comprueba si queda algún elemento por iterar*/
    public boolean hasNext() { 
    	if(!miLista.isEmpty()) {
    		//Si la cola en la que me encuentro tiene siguiente elemento devuelvo true
    	 if(miColaIterator.hasNext()) {
    		return true;
    	}else {
    		//Si la lista tiene siguiente elemento entonces lo obtengo, lo reseteo, y compruebo si tiene 
    		//siguiente elemento si es asi devuelve true, de lo contrario devuelve false.
    		if(lista.hasNext()) {
    			this.miCola = lista.getNext();
    			miColaIterator = this.miCola.iterator();
    			miColaIterator.reset();
    			if(miColaIterator.hasNext()) {
    				return true;
    			}
    		
    	      }
    	    }
    	}
    	return false;
    }
 
    /*Reinicia el iterador a la posición inicial*/
    public void reset() { 
    	//Pongo mi iterator de la lista en su primera cola
    	lista.reset();
    	//Avanzo cola por cola poniendo cada una de ellas en su priemra posicion
    	//Cuando llego al ultimo elemento de la lista, cola, vuelvo a resetear la lista.
    	while(lista.hasNext()) {
    		this.miCola = lista.getNext();
    		/*miColaIterator = lista.getNext()/*.iterator()*/;
    		miColaIterator.reset();
    		/*lista.getNext();*/
    		}
    	lista.reset();
    }
    
  }



  /* OPERACIONES PROPIAS DE ESTA CLASE */

  /*constructor por defecto: crea cola con prioridad vacía
   */
  BucketQueue(){ 
	  super();
	  this.miLista = new List <SamePriorityQueue<E>>();
	  
	  if(!miLista.isEmpty()) {
		  this.cola = this.miLista.get(1);
		  this.cola.iterator().reset();
	  }
	  
  }

  /* OPERACIONES PROPIAS DE LA INTERFAZ PRIORITYQUEUEIF */

  /*Devuelve el elemento más prioritario de la cola y que
   *llegó en primer lugar
   * @Pre !isEmpty()
   */
  public E getFirst() {
	  
	  if(!miLista.isEmpty()) {
	  return miLista.get(1).getFirst(); 
	  }
	  return null;
  }
 
  /*Añade un elemento a la cola de acuerdo a su prioridad
   *y su orden de llegada
   */
  public void enqueue(E elem, int prior) {
	  int posQueue = 1;
	  
	  lista = miLista.iterator();
	  
	  while(lista.hasNext() ) {
			 cola = lista.getNext();
			 
			if( cola.getPriority() == prior) {
				cola.enqueue(elem);
				this.size++;
				return;
			}else if( cola.getPriority() < prior) {
				SamePriorityQueue<E> newQueue = new SamePriorityQueue<E>(prior);
				newQueue.enqueue(elem);
				miLista.insert(posQueue, newQueue);
				this.size++;
				return;
				  
			}else if(posQueue == miLista.size()) {
				SamePriorityQueue<E> newQueue = new SamePriorityQueue<E>(prior);
				newQueue.enqueue(elem);
				miLista.insert(posQueue + 1, newQueue);
				this.size++;
				return;
			 
			}else {
				posQueue++;
			}
	     }
	  if(miLista.isEmpty()) {
		  SamePriorityQueue<E> newQueue = new SamePriorityQueue<E>(prior);
			newQueue.enqueue(elem);
			miLista.insert(1, newQueue);
			this.size++;
	  }
  }
		 
  /*Elimina el elemento más prioritario y que llegó a la cola
   *en primer lugar
   * @Pre !isEmpty()
   */
  public void dequeue() {
	  if(!miLista.isEmpty()) {
		  
		  cola = miLista.get(1);
		  cola.dequeue();
		  if(cola.isEmpty()) 
			  miLista.remove(1);
		  
		  this.size--;
	  }
  }

  /* OPERACIONES PROPIAS DE LA INTERFAZ SEQUENCEIF */

  /*Devuelve un iterador para la cola*/
  public IteratorIF<E> iterator() { 
	  return new PriorityQueueIterator();
  }
 
  /* OPERACIONES PROPIAS DE LA INTERFAZ COLLECTIONIF */

  /*Devuelve el número de elementos de la cola*/
  public int size() { 
	  return this.size;
	  
  }

  /*Decide si la cola está vacía*/
  public boolean isEmpty() { 
	  
	  return miLista.isEmpty();
  }
 
  /*Decide si la cola contiene el elemento dado por parámetro*/
  public boolean contains(E e) {
	  if(!miLista.isEmpty()) {
	   while(miLista.iterator().hasNext()) {
		   cola = miLista.iterator().getNext();
			  if(cola.contains(e)) {
				  return true;
			  }
          }
	  }
	  return false;
  }
 
  /*Elimina todos los elementos de la cola*/
  public void clear() {
	  if(!miLista.isEmpty()) {
		  while(miLista.iterator().hasNext()) {
			   miLista.iterator().getNext().clear();
		  }
		 miLista.clear(); 
	  }
  }
 
}

