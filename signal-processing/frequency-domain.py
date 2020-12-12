from scipy.fftpack import fft
import string
import pandas as pd
import numpy as np
import sciplot as plt


def read_lines(file):
    line = ""
    signal = []
    char_aux = ""
    for char in file.read():
        if char != " ":
            line = line + char
            char_aux = char
        else:
            if char_aux != " ":
                signal.append(line)
                line = ""
                char_aux = char
    return signal


# file = open("content/ECG.txt", "r")
# signal = read_lines(file)
# print (signal)

def a_exercise():
    print ("a) plotar o sinal no dominio do TEMPO, ou seja, amplitude da amostra  x segundo, mostrando uma janela minima de 5 segundos de sinal")
    data = np.loadtxt("content/ECG.txt")
    plt.plot(data[100000:103000])
    plt.show()

def b_exercise():
    print ("b) levantar o espectro de amplitude do sinal (com a janela de 5 segundos);")


def c_exercise():
    print ("c) verificar o tipo de ruido presente no sinal;")


def d_exercise():
    print ("d) filtrar o sinal com a transformada de Fourier removendo o ruido detectado em c;")


def e_exercise():
    print ("e) plotar o sinal FILTRADO no dominio do tempo;")


def f_exercise():
    print ("f) discuta o resultado obtido.")

a_exercise()