package ubadb.external.bufferManagement;

import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import ubadb.core.common.TransactionId;
import ubadb.external.bufferManagement.etc.PageReferenceTrace;
import ubadb.external.bufferManagement.etc.PageReferenceTraceSerializer;
import ubadb.external.bufferManagement.traceGenerators.BNLJTraceGenerator;
import ubadb.external.bufferManagement.traceGenerators.FileScanTraceGenerator;
import ubadb.external.bufferManagement.traceGenerators.INLJTraceGenerator;
import ubadb.external.bufferManagement.traceGenerators.IndexScanTraceGenerator;
import ubadb.external.bufferManagement.traceGenerators.MixedTraceGenerator;


public class MainTraceGenerator
{
    static String currentPath;

    public static void main(String[] args) throws Exception
	{
        currentPath = new File(".").getAbsoluteFile() + "/";
//		basicDataSet();
//		complexDataSet();
        specialDataSet();
	}
    private static void specialDataSet() throws Exception
    {
        PageReferenceTraceSerializer serializer = new PageReferenceTraceSerializer();

        String fileNameD1 = "generated/BNLJ-Colors-Gadgets.trace";
        PageReferenceTrace traceD1 = new BNLJTraceGenerator().generateBNLJ(1,"Gadgets", 1000, "Colors", 1, 1);
        serialize(fileNameD1, traceD1, serializer);
        String fileNameE1 = "generated/Index-Colors-Gadgets.trace";
        PageReferenceTrace traceE1 = new IndexScanTraceGenerator().generateMultipleIndexScanUnclusteredForASingleLeaf(1,"Gadgets", 1, 5, 5, 100);
        serialize(fileNameE1, traceE1, serializer);
        String fileNameF1 = "generated/Index-tp-tg.trace";
        PageReferenceTrace traceF1 = new IndexScanTraceGenerator().generateWeird(1,"Colors",200,100,"Gadgets",1000,10000);
        serialize(fileNameF1, traceF1, serializer);

        String fileNameG1 = "generated/INLJ-Style-Gadgets-tp-tg.trace";
        PageReferenceTrace traceG1 = new INLJTraceGenerator().generateINLJ(1,"Style", 100, 5, "Gadgets", 1000, 5, 2, 0, 5);
        serialize(fileNameG1, traceG1, serializer);
    }
    private static void basicDataSet() throws Exception
	{
		PageReferenceTraceSerializer serializer = new PageReferenceTraceSerializer();
		
		//File Scan
		String fileNameA1 = "generated/fileScan-Company.trace";
		PageReferenceTrace traceA1 = new FileScanTraceGenerator().generateFileScan(1, "Company", 10);
		serialize(fileNameA1, traceA1, serializer);
		
		String fileNameA2 = "generated/fileScan-Product.trace";
		PageReferenceTrace traceA2 = new FileScanTraceGenerator().generateFileScan(1, "Product", 100);
		serialize(fileNameA2, traceA2, serializer);
		
		String fileNameA3 = "generated/fileScan-Sale.trace";
		PageReferenceTrace traceA3 = new FileScanTraceGenerator().generateFileScan(1,"Sale", 1000);
		serialize(fileNameA3, traceA3, serializer);
		
		//Index Scan Clustered
		String fileNameB1 = "generated/indexScanClustered-Product.trace";
		PageReferenceTrace traceB1 = new IndexScanTraceGenerator().generateIndexScanClustered(1,"Product", 3, 10, 50);
		serialize(fileNameB1, traceB1, serializer);
		
		String fileNameB2 = "generated/indexScanClustered-Sale.trace";
		PageReferenceTrace traceB2 = new IndexScanTraceGenerator().generateIndexScanClustered(1,"Sale", 4, 200, 100);
		serialize(fileNameB2, traceB2, serializer);
		
		//Index Scan Unclustered
		String fileNameC1 = "generated/indexScanUnclustered-Product.trace";
		PageReferenceTrace traceC1 = new IndexScanTraceGenerator().generateIndexScanUnclusteredForASingleLeaf(1,"Product", 3, 40, 100);
		serialize(fileNameC1, traceC1, serializer);
		
		String fileNameC2 = "generated/indexScanUnclustered-Sale.trace";
		PageReferenceTrace traceC2 = new IndexScanTraceGenerator().generateIndexScanUnclusteredForASingleLeaf(1,"Sale", 4, 250, 1000);
		serialize(fileNameC2, traceC2, serializer);
		
		//BNLJ
		String fileNameD1 = "generated/BNLJ-ProductXSale-group_50.trace";
		PageReferenceTrace traceD1 = new BNLJTraceGenerator().generateBNLJ(1,"Product", 100, "Sale", 1000, 50);
		serialize(fileNameD1, traceD1, serializer);
		
		String fileNameD2 = "generated/BNLJ-ProductXSale-group_75.trace";
		PageReferenceTrace traceD2 = new BNLJTraceGenerator().generateBNLJ(1,"Product", 100, "Sale", 1000, 75);
		serialize(fileNameD2, traceD2, serializer);
		
		String fileNameD3 = "generated/BNLJ-ProductXSale-group_100.trace";
		PageReferenceTrace traceD3 = new BNLJTraceGenerator().generateBNLJ(1,"Product", 100, "Sale", 1000, 100);
		serialize(fileNameD3, traceD3, serializer);
		
		String fileNameD4 = "generated/BNLJ-SaleXProduct-group_100.trace";
		PageReferenceTrace traceD4 = new BNLJTraceGenerator().generateBNLJ(1,"Sale", 1000, "Product", 100, 100);
		serialize(fileNameD4, traceD4, serializer);

		String fileNameD5 = "generated/BNLJ-SaleXProduct-group_250.trace";
		PageReferenceTrace traceD5 = new BNLJTraceGenerator().generateBNLJ(1,"Sale", 1000, "Product", 100, 250);
		serialize(fileNameD5, traceD5, serializer);
	}
	
	private static void serialize(String fileName, PageReferenceTrace trace, PageReferenceTraceSerializer serializer) throws Exception
	{
        fileName=currentPath+fileName;
		serializer.write(trace, fileName);
		System.out.println("File '" + fileName + "' generated!!");
	}
	
	private static void complexDataSet() throws Exception
	{
		PageReferenceTraceSerializer serializer = new PageReferenceTraceSerializer();

		String folder = "generated/escenarios1";
		String file = "generated/mixed-filescans.trace";
		mixTraces(file,folder,100,5,serializer);

        folder = "generated/escenarios2";
        file = "generated/mixed-filescans-clustered.trace";
        mixTraces(file,folder,100,7,serializer);
	}

	private static void mixTraces(String fileNameForNewTrace, String folderName, int totalTracesCount, int maxConcurrentTracesCount, PageReferenceTraceSerializer serializer) throws Exception
	{
		List<PageReferenceTrace> tracesToMix = buildTracesToMix(folderName,totalTracesCount,serializer);
		
		PageReferenceTrace mixedTrace = new MixedTraceGenerator().generateMixedTrace(tracesToMix, totalTracesCount, maxConcurrentTracesCount);
		
		serializer.write(mixedTrace, fileNameForNewTrace);
		System.out.println("File " + fileNameForNewTrace + " generated");
	}

	private static List<PageReferenceTrace> buildTracesToMix(String folderName, int totalTracesCount, PageReferenceTraceSerializer serializer) throws Exception
	{
		List<PageReferenceTrace> tracesToMix = new ArrayList<>();
		Random random = new Random(System.currentTimeMillis());
		
		String[] traceFiles = Paths.get(currentPath+folderName).toFile().list();
		
		for(int i=0; i < totalTracesCount; i++)
		{
			int anyTraceIndex = random.nextInt(traceFiles.length); 
			PageReferenceTrace anyTrace = serializer.read(folderName + "/" + traceFiles[anyTraceIndex]);
			anyTrace.changeTransactionId(new TransactionId(i));
			
			tracesToMix.add(anyTrace);
		}
		
		return tracesToMix;
	}
}
