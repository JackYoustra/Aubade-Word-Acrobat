import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.NoSuchElementException;
import java.util.Scanner;


public class AubadeFileInteractor {

	public final static String[] lineList;
	public final static String[] wordList;
	
	static{
		// needs to be in this order
		lineList = getLineList();
		wordList = getWordList();
	}
	
	private static String[] getWordList(){
		ArrayList<String> stringList = new ArrayList<String>();
		for(String s : lineList){
			String[] words = s.split("\\s+"); // split on whitespace
			for(String word : words) stringList.add(word);
		}
		String[] retWordList = stringList.toArray(new String[stringList.size()]);
		return retWordList;
	}

	private static String[] getLineList() {
		Scanner aubadeScanner = null;
		try {
			aubadeScanner = new Scanner(new File("src/Aubade.txt"));
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
		}
		ArrayList<String> stringList = new ArrayList<>();
		try{
			while(true){
				String currentLine = aubadeScanner.nextLine();
				if(currentLine.length() > 0) stringList.add(currentLine);
			}
		} catch (NoSuchElementException e){
			// at end
			System.out.println("end");
		}
		aubadeScanner.close();
		String[] strlineList = stringList.toArray(new String[stringList.size()]);
		return strlineList;
	}
	
}
