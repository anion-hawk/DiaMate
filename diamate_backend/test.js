diseases = ["Insulin resistance", 'Diabetes insipidus', 'Cataract', 'PCOS', 'Hypertension', 'Thyroid disease', 'Coeliac disease', 'GGGg']

const transformedDiseases = diseases.map(disease => disease.toLowerCase().replace(/ /g, '_'));

console.log(transformedDiseases)