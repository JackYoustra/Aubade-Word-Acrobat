import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.NoSuchElementException;
import java.util.Scanner;


public class AubadeFileInteractor {

	public final static String[] wordList;
	
	static{
		wordList = getWordList();
	}

	private static String[] getWordList() {
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
		String[] strWordList = stringList.toArray(new String[stringList.size()]);
		return strWordList;
	}
	
}
