package es.uned.lsi.eped.pract2020_2021;

import es.uned.lsi.eped.DataStructures.BSTree;
import es.uned.lsi.eped.DataStructures.BSTreeIF;
import es.uned.lsi.eped.DataStructures.BSTreeIF.IteratorModes;
import es.uned.lsi.eped.DataStructures.BSTreeIF.Order;
import es.uned.lsi.eped.DataStructures.Collection;
import es.uned.lsi.eped.DataStructures.IteratorIF;


/*Representa una cola con prioridad implementada mediante un árbol binario de búsqueda de SamePriorityQueue*/
public class BSTPriorityQueue<E> extends Collection<E> implements PriorityQueueIF<E> {
	private BSTreeIF<SamePriorityQueue<E>> abb;
	private SamePriorityQueue<E> miCola;

    
  //LA DEFINICIÓN DE LOS ATRIBUTOS DE LA CLASE ES TAREA DE CADA ESTUDIANTE

  /* Clase privada que implementa un iterador para la *
   * cola con prioridad basada en secuencia.          */
  public class PriorityQueueIterator implements IteratorIF<E> {

    //LA DEFINICIÓN DE LOS ATRIBUTOS DE LA CLASE ES TAREA DE CADA ESTUDIANTE
	  private IteratorIF<E> miColaIterator;
	  private IteratorIF <SamePriorityQueue<E>> tree;
    /*Constructor por defecto*/
    protected PriorityQueueIterator(){ 
    	super();
    	this.tree = abb.iterator(IteratorModes.REVERSEORDER);
    	if(tree.hasNext()) {
    		miCola = tree.getNext();
    		this.miColaIterator = miCola.iterator();
    		this.miColaIterator.reset();
    		
    	}
    	
    }

    /*Devuelve el siguiente elemento de la iteración*/
    public E getNext() { 
    	if(this.miColaIterator.hasNext()) {
    		return this.miColaIterator.getNext();
    	}else {
    	return null;
      }
    } 
    /*Comprueba si queda algún elemento por iterar*/
    public boolean hasNext() { 
    	if(miColaIterator != null) {
    	  if(miColaIterator.hasNext()) {
    		return true;
    	}else {
    		if(tree.hasNext()) {
    			miCola = tree.getNext();
    			miColaIterator = miCola.iterator();
    			miColaIterator.reset();
    			return miColaIterator.hasNext();
    			
    		}else {
    			return false;
    		}
    	  }
    	}else {
    	return  false;
    	}
    }
 
    /*Reinicia el iterador a la posición inicial*/
    public void reset() {
    	tree.reset();
    	while(tree.hasNext()) {
    		miCola = tree.getNext();
    		miColaIterator.reset();
    	}
    	tree.reset();
  }
  }


  /* OPERACIONES PROPIAS DE ESTA CLASE */

  /*constructor por defecto: crea cola con prioridad vacía
   */
  BSTPriorityQueue(){ 
	  super();
	  this.abb = new BSTree<SamePriorityQueue<E>>(Order.ASCENDING);
  }

  /* OPERACIONES PROPIAS DE LA INTERFAZ PRIORITYQUEUEIF */

  /*Devuelve el elemento más prioritario de la cola y que
   *llegó en primer lugar
   * @Pre !isEmpty()
   */
  public E getFirst() { 
      if(!abb.isEmpty()) {
    	  return abb.iterator(IteratorModes.REVERSEORDER).getNext().getFirst();
      }
	  return null;  
  }
 
  /*Añade un elemento a la cola de acuerdo a su prioridad
   *y su orden de llegada
   */
  public void enqueue(E elem, int prior) { 
	  
	  /*if(!abb.isEmpty()) {*/
	  IteratorIF<SamePriorityQueue<E>> tree = abb.iterator(IteratorModes.DIRECTORDER);
		while(tree.hasNext()) {
            miCola = tree.getNext();
			if(miCola.getPriority() == prior) {
				miCola.enqueue(elem);
				this.size++;
				return;
			}
		}
				SamePriorityQueue<E> newCola = new SamePriorityQueue<E>(prior);
				abb.add(newCola);
				newCola.enqueue(elem);
				this.size++;
				return;
	  
  }

  /*Elimina el elemento más prioritario y que llegó a la cola
   *en primer lugar
   * @Pre !isEmpty()
   */
  public void dequeue() { 
	  if(!abb.isEmpty()) {
		  IteratorIF<SamePriorityQueue<E>> tree = abb.iterator(IteratorModes.REVERSEORDER);
		  if(tree.hasNext()) {
			  miCola = tree.getNext();
			  miCola.dequeue();
			  if(miCola.isEmpty()) {
				  abb.remove(miCola);
			  }
			  this.size--;
		  }
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
	  if(abb.getRoot() == null) {
		  return true;
	  }
		  return false;
	  
  }
 
  /*Decide si la cola contiene el elemento dado por parámetro*/
  public boolean contains(E e) { 
	  if(!abb.isEmpty()) {
			while(abb.iterator(IteratorModes.DIRECTORDER).hasNext()) {
	            miCola = abb.iterator(IteratorModes.DIRECTORDER).getNext();
	            if(miCola.contains(e)) {
	            	return true;
	            }
			}
	  }
	return false;
  }
 
  /*Elimina todos los elementos de la cola*/
  public void clear() { 
	  
	  abb.iterator(IteratorModes.DIRECTORDER).reset();
	  if(!abb.isEmpty()) {
		 iterator().reset();
			while(abb.iterator(IteratorModes.DIRECTORDER).hasNext() ) {
	            abb.iterator(IteratorModes.DIRECTORDER).getNext().clear();    
			}
			abb.clear();
	  }
  }
 
}

