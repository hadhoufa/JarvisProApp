from kivy.app import App
from kivy.uix.label import Label
class MyApp(App):
    def build(self):
        return Label(text="J.A.R.V.I.S. Absolute System Online.")
if __name__ == '__main__':
    MyApp().run()
