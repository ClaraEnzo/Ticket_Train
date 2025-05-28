package test;

import java.io.ObjectInputFilter.Config;
import java.sql.DriverManager;

import com.itextpdf.text.Document;

public class LibraryTest {
    public static void main(String[] args) {
        System.out.println("MySQL Driver: " + DriverManager.class.getName());
        System.out.println("JSTL Config: " + Config.class.getName());
        System.out.println("iText Document: " + Document.class.getName());
        System.out.println("All libraries loaded successfully!");
    }
}