package eu.flutter.netguard.data;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.view.View;

import com.github.mikephil.charting.charts.PieChart;
import com.github.mikephil.charting.data.PieData;
import com.github.mikephil.charting.data.PieDataSet;
import com.github.mikephil.charting.data.PieEntry;

import java.util.ArrayList;
import java.util.List;

import eu.flutter.netguard.flutter.NativeBridge;
import eu.flutter.netguard.R;
import eu.flutter.netguard.utils.Util;

public class StatusNotificationData {
    private final String title;
    private final long packetCountTotal;
    private final long packetCountBlocked;
    private final Bitmap chart;

    public StatusNotificationData(Context context, String title, NativeBridge.SessionStatistics sessionStatistics){
        this.title = title;
        packetCountTotal = ModelExtensions.SessionStatistics.packetCount(sessionStatistics);
        packetCountBlocked = sessionStatistics.getPacketCountBlocked();
        chart = getStatusChart(context, sessionStatistics);
    }

    public String getTitle(){
        return title;
    }
    public String getPacketCountTotal(){
        return "Packets (total): " + packetCountTotal;
    }
    public String getPacketCountBlocked(){
        return "Packets (blocked): " + packetCountBlocked;
    }
    public Bitmap getChart(){
        return chart;
    }

    private Bitmap getStatusChart(Context context, NativeBridge.SessionStatistics sessionStatistics){
        int size = Util.dips2pixels(300, context);

        // Create a LineChart (or PieChart, BarChart, etc.)
        PieChart chart = new PieChart(context);

        // Create entries
        List<PieEntry> entries = new ArrayList<>();
        entries.add(new PieEntry(sessionStatistics.getPacketCountAllowed(), "Allowed"));
        entries.add(new PieEntry(sessionStatistics.getPacketCountBlocked(), "Blocked"));

        // Create data set
        PieDataSet dataSet = new PieDataSet(entries, "Usage");
        dataSet.setColors(
                Util.getColor(context, R.color.green),
                Util.getColor(context, R.color.red)
        );

        // Optional styling
        dataSet.setSliceSpace(0f);
        dataSet.setValueTextColor(Color.BLACK);
        dataSet.setValueTextSize(16f);

        // Create data object
        PieData pieData = new PieData(dataSet);

        // Set data and refresh chart
        chart.setData(pieData);
        chart.setDrawHoleEnabled(true); // or true for donut style
        chart.setHoleRadius(10f);
        chart.setHoleColor(Color.TRANSPARENT);

        chart.setTransparentCircleRadius(0f);
        chart.setTransparentCircleAlpha(0);
        chart.setTransparentCircleColor(Color.TRANSPARENT);
        chart.getDescription().setEnabled(false);

        //chart.setUsePercentValues(true);  // Show percentages
        chart.setEntryLabelColor(Color.BLACK);
        chart.setEntryLabelTextSize(12f);
        chart.getLegend().setEnabled(false); // Hide legend if not needed

        chart.invalidate(); // Refresh chart

        // Measure and layout offscreen
        chart.measure(
                View.MeasureSpec.makeMeasureSpec(size, View.MeasureSpec.EXACTLY),
                View.MeasureSpec.makeMeasureSpec(size, View.MeasureSpec.EXACTLY)
        );
        //chart.layout(0, 0, chart.getMeasuredWidth(), chart.getMeasuredHeight());
        chart.layout(0, 0, size, size);

        // Create a bitmap
        Bitmap bitmap = Bitmap.createBitmap(
                chart.getMeasuredWidth(),
                chart.getMeasuredHeight(),
                Bitmap.Config.ARGB_8888
        );

        // Draw the chart onto the bitmap
        Canvas canvas = new Canvas(bitmap);
        chart.draw(canvas);

        return bitmap;
    }
}
