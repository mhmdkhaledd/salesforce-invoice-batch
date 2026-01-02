public class StringListTest {

    // Public static method
    public static List<String> generateStringList(Integer count) {
        List<String> result = new List<String>();
        
        // Loop to add elements in the format "Test n"
        for (Integer i = 0; i < count; i++) {
            result.add('Test ' + i);
        }
        
        return result;
    }
}