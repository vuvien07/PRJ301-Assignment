/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import org.apache.tomcat.jakartaee.commons.lang3.tuple.Pair;

/**
 *
 * @author Admin
 */
public class DateTimeTool {

    public static java.sql.Date convertUtilDateToSqlDate(java.util.Date utilDate) {
        if (utilDate != null) {
            Calendar cal = Calendar.getInstance();
            cal.setTime(utilDate);
            cal.set(Calendar.HOUR_OF_DAY, 0);
            cal.set(Calendar.MINUTE, 0);
            cal.set(Calendar.SECOND, 0);
            cal.set(Calendar.MILLISECOND, 0);
            return new java.sql.Date(cal.getTimeInMillis());
        } else {
            return null;
        }
    }

    public static Date addDaysToDate(Date date, int days) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DAY_OF_YEAR, days);
        return cal.getTime();
    }

    public static ArrayList<java.sql.Date> getDatesBetween(java.sql.Date fromDate, java.sql.Date toDate) {
        if (fromDate == null || toDate == null) {
            throw new IllegalArgumentException("Both from date and to date can't be null");
        }
        if (fromDate.after(toDate)) {
            throw new IllegalArgumentException("From date can't be after as to date");
        }
        Date from = new Date(fromDate.getTime());
        Date to = new Date(toDate.getTime());
        Date temp = from;
        ArrayList<java.sql.Date> dates = new ArrayList<>();
        while (!temp.after(to)) {
            dates.add(convertUtilDateToSqlDate(temp));
            temp = addDaysToDate(temp, 1);
        }
        return dates;
    }

    public static Map<java.sql.Date, java.sql.Date> getWeeksByYear(int year) {
        int week = 1;
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.YEAR, year); // Năm bạn muốn hiển thị
        calendar.set(Calendar.MONTH, Calendar.JANUARY); // Tháng 1 (index bắt đầu từ 0)
        calendar.set(Calendar.DAY_OF_MONTH, 1); // Ngày 1
        if (calendar.get(Calendar.DAY_OF_WEEK) == Calendar.MONDAY) {
        } else if (calendar.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
            calendar.add(Calendar.DATE, 1);
        } else {
            while (calendar.get(Calendar.DAY_OF_WEEK) != Calendar.MONDAY) {
                calendar.add(Calendar.DATE, -1);
            }
        }
        Map<java.sql.Date, java.sql.Date> weeks = new TreeMap<>();
        while (week != 53) {
            Date utilValue = calendar.getTime();
            java.sql.Date key = new java.sql.Date(utilValue.getTime());
            System.out.println("Tuần " + week + ": "
                    + calendar.get(Calendar.DATE) + " "
                    + calendar.getDisplayName(Calendar.MONTH, Calendar.LONG, java.util.Locale.getDefault()) + " "
                    + calendar.get(Calendar.YEAR));
            calendar.add(Calendar.DATE, 6);
            utilValue = calendar.getTime();
            java.sql.Date value = new java.sql.Date(utilValue.getTime());
            weeks.put(key, value);
            calendar.add(Calendar.DATE, 1);
            utilValue = calendar.getTime();
            week++;
        }
        return weeks;
    }

    public static void main(String[] args) throws ParseException {
        Map<java.sql.Date, java.sql.Date> weeks = getWeeksByYear(2024);
        System.out.println(weeks);
    }

}
