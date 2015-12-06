from sklearn import cluster, datasets
iris = datasets.load_iris()
x_iris = iris.data
y_iris = iris.target

k_means = cluster.KMeans(n_clusters=2, max_iter = 1000)
print k_means.fit(x_iris)
print k_means.labels_
print y_iris
print x_iris
print k_means.cluster_centers_
