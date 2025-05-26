package utils;

import java.util.regex.Pattern;

public class XSSUtil {

    // Danh sách từ khóa JS nguy hiểm cần cấm
    private static final String[] BANNED_KEYWORDS = {
        "script", "onload", "onclick", "onerror", "onmouseover", "onmouseenter",
        "onmouseleave", "javascript:", "eval(", "document.cookie", "alert("
    };

    // Regex chuẩn để kiểm tra chuỗi hợp lệ
    // Tên danh mục (chữ, số, khoảng trắng, dấu gạch ngang)
    private static final Pattern VALID_NAME_PATTERN = Pattern.compile("^[a-zA-Z0-9 \\-]{1,50}$");
    // Mô tả (chữ, số, dấu phẩy, chấm, khoảng trắng)
    private static final Pattern VALID_DESCRIPTION_PATTERN = Pattern.compile("^[a-zA-Z0-9 ,.\\-]{0,1000}$");
    // DiscountName (chữ, số, dấu gạch ngang, dấu chấm, dấu phẩy, khoảng trắng)
    private static final Pattern VALID_DISCOUNT_NAME_PATTERN = Pattern.compile("^[a-zA-Z0-9 \\-.,]{1,255}$");

    // Kiểm tra xem chuỗi có chứa từ khóa JS nguy hiểm không
    public static boolean containsBannedKeyword(String input) {
        if (input == null) return false;
        String lower = input.toLowerCase();
        for (String keyword : BANNED_KEYWORDS) {
            if (lower.contains(keyword)) {
                return true;
            }
        }
        return false;
    }

    // Kiểm tra tên danh mục hợp lệ
    public static boolean isValidCategoryName(String input) {
        if (input == null) return false;
        return VALID_NAME_PATTERN.matcher(input).matches() && !containsBannedKeyword(input);
    }

    // Kiểm tra mô tả hợp lệ
    public static boolean isValidCategoryDescription(String input) {
        if (input == null) return true; // Mô tả có thể trống
        return VALID_DESCRIPTION_PATTERN.matcher(input).matches() && !containsBannedKeyword(input);
    }

    // Kiểm tra discountName hợp lệ
    public static boolean isValidDiscountName(String input) {
        if (input == null) return false;
        return VALID_DISCOUNT_NAME_PATTERN.matcher(input).matches() && !containsBannedKeyword(input);
    }
}
