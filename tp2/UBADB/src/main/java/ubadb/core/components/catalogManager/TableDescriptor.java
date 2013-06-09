package ubadb.core.components.catalogManager;

import ubadb.core.common.TableId;
import ubadb.core.components.bufferManager.pools.multiple.BufferPoolId;

public class TableDescriptor
{
	private TableId tableId;
	private String tableName;
	private String tablePath;
	private BufferPoolId tablePool;
	
	public TableDescriptor(TableId tableId, String tableName, String tablePath,
			BufferPoolId tablePool) {
		this.tableId = tableId;
		this.tableName = tableName;
		this.tablePath = tablePath;
		this.tablePool = tablePool;
	}

	public BufferPoolId getTablePool() {
		return tablePool;
	}

	public TableId getTableId()
	{
		return tableId;
	}

	public String getTableName()
	{
		return tableName;
	}

	public String getTablePath()
	{
		return tablePath;
	}
}
