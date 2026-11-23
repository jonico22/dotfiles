# 10. Elgato: Stream Deck y micrófono Wave (opcional)

> **Opcional.** Esta guía solo sirve si tienes un **Stream Deck** o un micrófono **Elgato Wave**.
> Si no tienes estos periféricos, sáltala: `install.sh` (grupo `escritorio`) pregunta antes de instalar algo de aquí
> (responde `N`), y el archivo de WirePlumber no hace nada sin un Wave conectado.

## Qué se instala

| Programa | Fuente | Para qué |
|---|---|---|
| [OpenDeck](https://github.com/nekename/OpenDeck) | Flatpak (Flathub) | Configurar los botones y diales del Stream Deck sin `sudo` |
| [Pipeweaver](https://github.com/pipeweaver/pipeweaver) | Flatpak `--user` (repo del autor, sin `sudo`) | Mezclador tipo Wave Link: canales separados para sistema, navegador y micrófono |
| EasyEffects | apt (sin root: Flatpak) | Filtros para el micrófono (ruido, compresor, ecualizador) |
| qpwgraph | apt (sin root: Flatpak) | Ver y conectar el audio de PipeWire de forma visual |

EasyEffects y qpwgraph están en el grupo multimedia (`packages/nativas.txt`) porque sirven con cualquier micrófono.

## Configuración

`wireplumber/51-elgato-wave.conf` se copia a `~/.config/wireplumber/wireplumber.conf.d/`. Hace dos cosas:

- Evita que PipeWire suspenda el Wave entre usos (si no, se escucha un "clic" o se corta el inicio).
- Fuerza el formato `S24LE`, el único que acepta el Wave:3.

Para aplicarlo sin reiniciar:

```bash
systemctl --user restart wireplumber pipewire pipewire-pulse
```

El acceso al Stream Deck sin `sudo` ya lo da Ubuntu (regla `70-av-production.hwdb` de systemd), así que no
hace falta ninguna regla udev.

## Pipeweaver: que no quede en silencio

Pipeweaver arranca con los canales físicos **sin dispositivo**. Si no los asignas, no se escucha nada:

1. Abre Pipeweaver → **Devices**.
2. En **Microphone** elige el Wave.
3. En **Headphones** elige tu salida (parlantes, HDMI o audífonos).
4. En **Applications** revisa a qué canal va cada app (por ejemplo Chrome → Browser).

Para probar el micrófono (graba 5 segundos y los reproduce):

```bash
pw-record --target pipeweaver_chat_mic --rate 48000 --channels 1 /tmp/prueba.wav & sleep 5; kill $!; pw-play /tmp/prueba.wav
```

## OBS

PipeWire ya trabaja fijo a 48 kHz. En OBS pon **Ajustes → Audio → Frecuencia de muestreo → 48 kHz**.

## Problemas conocidos

- **El Wave se cuelga o `wpctl` no responde:** suele ser falta de energía USB. Conéctalo a un hub con
  alimentación propia o directo al PC, no a un hub junto al Stream Deck. En `journalctl -k` aparece
  `usb_set_interface failed (-110)`.
- **Stream Deck en negro tras suspender:** OpenDeck no recibe eventos de energía; ciérralo y vuelve a abrirlo.
- **Pipeweaver no arranca solo:** activa el inicio automático en su ⚙. Su interfaz web escucha en
  `0.0.0.0:14565` (visible en la red local).
