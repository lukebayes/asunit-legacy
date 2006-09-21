
import asunit.util.Iterator;
import asunit.errors.IllegalOperationError;

class asunit.util.ArrayIterator implements Iterator {

	private var list:Array;
	private var index:Number = 0;

	public function ArrayIterator(list:Array) {
		if(list == null) {
			throw new IllegalOperationError("ArrayIterator needs an array in it's constructor");
		}
		this.list = list;
	}

	public function hasNext():Boolean {
		return (list[index] != null);
	}

	public function next():Object {
		return list[index++];
	}
}