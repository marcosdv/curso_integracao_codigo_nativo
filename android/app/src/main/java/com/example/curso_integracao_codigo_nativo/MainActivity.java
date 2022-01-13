package com.example.curso_integracao_codigo_nativo;

import android.os.Bundle;
import android.widget.ImageView;

import androidx.annotation.Nullable;

import com.yhao.floatwindow.FloatWindow;
import com.yhao.floatwindow.Screen;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "floating_button";
    private MethodChannel channel;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        channel = new  MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL);

        channel.setMethodCallHandler((call, result) -> {
            switch (call.method) {
                case "criarBotao":
                    criarBotao();
                    break;
                case "mostrarBotao":
                    mostrarBotao();
                    break;
                case "ocultarBotao":
                    ocultarBotao();
                    break;
                case "isShowing":
                    result.success(FloatWindow.get().isShowing());
                    break;
                default:
                    result.notImplemented();
            }
        });
    }

    @Override
    protected void onDestroy() {
        FloatWindow.destroy();
        super.onDestroy();
    }

    private void criarBotao() {
        ImageView img = new ImageView(getApplicationContext());
        img.setImageResource(R.drawable.btn_add);

        FloatWindow.with(getApplicationContext())
            .setView(img)
            .setWidth(Screen.width, 0.15f)
            .setHeight(Screen.width, 0.15f)
            .setX(Screen.width, 0.8f)
            .setY(Screen.height, 0.3f)
            .setDesktopShow(true)
            .build();

        img.setOnClickListener(view -> {
            channel.invokeMethod("cliqueBotao", null);
        });
    }

    private void mostrarBotao() {
        FloatWindow.get().show();
    }

    private void ocultarBotao() {
        FloatWindow.get().hide();
    }
}
