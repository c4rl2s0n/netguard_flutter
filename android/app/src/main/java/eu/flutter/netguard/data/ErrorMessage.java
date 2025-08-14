package eu.flutter.netguard.data;

public class ErrorMessage {
    public final String errorCode;
    public final String text;
    public final Object details;
    public ErrorMessage(String errorCode, String text, Object details){
        this.errorCode = errorCode;
        this.text = text;
        this.details = details;
    }
}
