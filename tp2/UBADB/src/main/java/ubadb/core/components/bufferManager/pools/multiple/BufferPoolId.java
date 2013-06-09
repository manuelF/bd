package ubadb.core.components.bufferManager.pools.multiple;

public enum BufferPoolId {
	KEEP,RECYCLE,DEFAULT;
	
	public static BufferPoolId fromString(String s){
		if(s == null) return DEFAULT;
		if(s.equalsIgnoreCase("KEEP")) return KEEP;
		if(s.equalsIgnoreCase("RECYCLE")) return RECYCLE;
		if(s.equalsIgnoreCase("DEFAULT")) return DEFAULT;
		return DEFAULT;
	}
}
