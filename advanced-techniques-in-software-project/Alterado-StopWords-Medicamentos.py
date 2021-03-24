import nltk

nltk.download('punkt')
from nltk.tokenize import sent_tokenize, word_tokenize
from nltk.corpus import stopwords

nltk.download('stopwords')
import string
import urllib.request
from bs4 import BeautifulSoup
import pandas as pd
import numpy as np


def add_new_stop_words(stop_words):
    new_stop_words = ['ColateraisQuais', 'falta', 'males', 'pode', 'causar', 'Alguns',
                      'efeitos', 'colaterais', 'comuns', 'Amitriptilina', 'aumento',
                      'incluem', 'Fluoxetina', 'Sertralina\u200b', 'podem', 'incluir',
                      'Bupropiona', 'reações', 'Os', 'efeitos', 'adversos', 'comuns',
                      'provocados', 'uso', 'paroxetina', 'são', 'abundante', 'frequentes',
                      'problemas', '(', '1', '1%', 'Trazodona', 'Pacientes', 'sexo', 'masculino',
                      'tratamento', 'devem', 'interromper', 'imediato', 'administração',
                      'medicamento', 'consultar', 'médico', 'dá', 'pode', 'provocar', 'Espran',
                      'atingir', "causar", "mulheres", 'ocorrer', 'operar', 'máquinas', 'certeza',
                      'medicamento', 'vez', 'fluoxetina', 'interferir', 'capacidade', 'ação',
                      'pacientes', 'tratados', 'produto', 'relatados', 'seguintes', 'fluoxetina',
                      'todoSintomas', 'autonômicos', 'incluindo', 'caracterizada', 'conjunto',
                      'características', 'clínicas', 'atividade', 'autônomo', 'camadas', 'profundas',
                      'incluindo', 'sintomas', 'associados', 'frequentemente', 'observadas',
                      'sintomas', 'geralmente', 'leves', 'moderados', 'limitados', 'entanto',
                      'alguns', 'pacientes', 'ser', 'graves', 'prolongados', 'razão', 'é',
                      'aconselhável', 'cloridrato', 'necessário', 'dose', 'deve', 'ser',
                      'gradualmente', 'reduzida', 'relatos', 'ocorridos', 'sistemas',
                      'reação', 'semelhante', 'doença', 'soro', 'ingestão', 'oral', '150',
                      'mg', 'Trazodona', 'concentração', 'máxima', 'organismo', 'alcançada',
                      'tempo', 'máximo', '4', 'horas', 'após', 'ingestão', '1', '%', 'ADVERSOSOs',
                      'apresentarem', 'inapropriado', 'apresentam']
    for word in new_stop_words:
        if word not in stop_words:
            stop_words.add(word)
    return stop_words


def get_medicine_url_data(medicine_url):
    medicine_url_data = {}
    for url in medicine_url:
        medicine_url_data[url] = urllib.request.urlopen(medicine_url[url])
    return medicine_url_data


def get_stop_words():
    return add_new_stop_words(set(stopwords.words('portuguese')))


def get_punctuations():
    return list(string.punctuation)


def get_medicine_text_spliters(medicine):
    medicine_spliters = {
        'Fluoxetina': ["Colaterais", "Contraindicações"],
        'Amitriptilina': ["Colaterais", "Contraindicações"],
        'Sertralina': ["Colaterais", "Contraindicações"],
        'Bupropiona': ["Colaterais", "Contraindicações"],
        'Paroxetina': ["Colaterais", "Contraindicações"],
        'Citalopram': ["Colaterais", "Contraindicações"],
        'Imipramina': ["ADVERSOS", "RECEITUÁRIO"],
        'Selegilina': ["ADVERSOS", "RECEITUÁRIO"],
        'Trazodona': ["Colaterais", "consultar"],
        'Escitalopram': ["Colaterais", "Advertências"]
    }
    return medicine_spliters[medicine]


def split_medicine_data(bytes, spliters):
    begin_spliter = 0
    end_spliter = 1
    soup = BeautifulSoup(bytes, "lxml")
    text = soup.get_text(strip=True)
    text = text[text.find(spliters[begin_spliter]):text.find(spliters[end_spliter])]
    text = [t for t in text.split()]
    return text


def filter_medicine_words(medicine_url_data):
    medicine_words_filtered = {}
    for medicine in medicine_url_data:
        medicine_words_filtered[medicine] = []
        medicine_words_filtered[medicine] = stop_words_filter(medicine_url_data[medicine], medicine_words_filtered[medicine], get_medicine_text_spliters(medicine))
    return medicine_words_filtered


def extract_end_punctuation(term, char, words_filtered):
    word = []
    word = term[:term.index(char)]
    if (word not in get_stop_words()) and (len(words_filtered) > 0) and (
            word not in words_filtered[-1]) and (words_filtered[-1] not in word):
        words_filtered.append(word)
    return words_filtered


def extract_middle_punctuation(term, char, words_filtered):
    word = []
    word = term[:term.index(char)]
    if word.isalpha():
        if (word not in get_stop_words()) and (len(words_filtered) > 0) and (
                word not in words_filtered[-1]) and (words_filtered[-1] not in word):
            words_filtered.append(word)
    else:
        if word not in get_stop_words() and word not in get_punctuations():
            if any(char in word for char in get_punctuations()):
                words_filtered = extract_punctuation(word, words_filtered)
    return words_filtered


def extract_begin_punctuation(term, words_filtered):
    word = []
    word = term[1:]
    if word.isalpha():
        if (word not in get_stop_words()) and (len(words_filtered) > 0) and (
                word not in words_filtered[-1]) and (words_filtered[-1] not in word):
            words_filtered.append(word)
    else:
        if word not in get_stop_words() and word not in get_punctuations():
            if any(char in word for char in get_punctuations()):
                words_filtered = extract_punctuation(word, words_filtered)
    return words_filtered


def extract_punctuation(term, words_filtered):
    for char in term:
        if char in get_punctuations():
            if term.index(char) == len(term) - 1:
                return extract_end_punctuation(term, char, words_filtered)
            elif term.index(char) != 0:
                return extract_middle_punctuation(term, char, words_filtered)
            elif term.index(char) == 0:
                return extract_begin_punctuation(term, words_filtered)


def stop_words_filter(medicine_data, words_filtered, spliters):
    text = split_medicine_data(medicine_data, spliters)
    stop_words = get_stop_words()
    punctuations = get_punctuations()

    for term in text:
        if term not in stop_words and term not in punctuations:
            if any(char in term for char in punctuations):
                words_filtered = extract_punctuation(term, words_filtered)
            else:
                words_filtered.append(term)
    return words_filtered


def generate_symptoms_list(medicine_words_filtered):
    symptoms = []
    for medicine in medicine_words_filtered:
        for word in medicine_words_filtered[medicine]:
            if word not in symptoms:
                symptoms.append(word)
    return symptoms


def generate_matrix(medicine_words_filtered, symptoms):
    matrix = np.zeros((len(medicine_words_filtered) + 1, len(symptoms)))
    count_symptoms = 0
    total_index = 10

    for word in symptoms:
        count_medicine = 0
        for medicine in medicine_words_filtered:
            matrix[count_medicine][count_symptoms] = medicine_words_filtered[medicine].count(word)
            matrix[total_index][count_symptoms] = matrix[total_index][count_symptoms] + matrix[
                count_medicine][count_symptoms]
            count_medicine = count_medicine + 1
        count_symptoms = count_symptoms + 1
    return matrix


def generate_medicine_array(medicine_words_filtered):
    medicines = []
    for medicine in medicine_words_filtered:
        medicines.append(medicine)
    medicines.append("Total")
    return medicines


def generate_data_frame(matrix, symptoms, medicines):
    data_frame = pd.DataFrame(data=matrix,
                              columns=symptoms,
                              index=medicines)
    return data_frame


def export_to_csv(data_frame):
    data_frame.to_csv("medicinexsymptoms.csv")


def identify_major_occurrence_medicine(matrix, symptoms, medicines):
    occurrence = {}
    count = 0
    for medicine in medicines:
        occurrence[medicine] = symptoms[np.argmax(matrix[count])]
        count = count + 1
    return occurrence


def print_data_frame(data_frame):
    print(data_frame)


def print_occurrence(occurrence):
    print("Termos de maior ocorrência:")
    for medicine in occurrence:
        print(medicine + ": " + occurrence[medicine])


medicine_url = {
    'Fluoxetina': 'https://www.bulario.com/fluoxetina/',
    'Amitriptilina': 'https://www.bulario.com/amitriptilina/',
    'Sertralina': 'https://www.bulario.com/sertralina_50_mg/',
    'Bupropiona': 'https://www.bulario.com/bupropiona/',
    'Paroxetina': 'https://www.bulario.com/paroxetina/',
    'Citalopram': 'https://www.bulario.com/citalopram/',
    'Imipramina': 'http://www.medicamentosesaude.com/bula-de-remedio-imipramina/',
    'Selegilina': 'http://www.medicamentosesaude.com/bula-de-remedio-selegilina/',
    'Trazodona': 'https://www.bulario.com/trazodona/',
    'Escitalopram': 'https://www.bulario.com/espran/'
}
medicine_words_filtered = filter_medicine_words(get_medicine_url_data(medicine_url))
symptoms = generate_symptoms_list(medicine_words_filtered)
medicines = generate_medicine_array(medicine_words_filtered)
matrix = generate_matrix(medicine_words_filtered, symptoms)
data_frame = generate_data_frame(matrix, symptoms, medicines)

print_data_frame(data_frame)
print_occurrence(identify_major_occurrence_medicine(matrix, symptoms, medicines))
export_to_csv(data_frame)
