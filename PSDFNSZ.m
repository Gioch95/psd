function [pxx,f,Delta,Theta,Alpha,Beta,Gamma]=PSDFNSZ(Y,B,fs)
load('B')

%matrice 3 dimensioni con zeros
inDir='C:\Users\gioiachiodi\Documents\MATLAB\FNSZ 30 secondi\';%segnale non filtrato
outDir='C:\Users\gioiachiodi\Documents\MATLAB\FNSZPSD\';%qui ho inserito un \ in più
fs=250;
estensione='*.mat';
cases=dir(fullfile(inDir,estensione));
for i=1:length(cases)
     load(strcat(inDir,cases(i).name));%ciclo for per ogni canale
    %si prendono epoche di 5 secondi;
     for j=1:6 %secondi epoche
         for k=1:(min(size(Y)))
             
     [B(j,k,1),f]=pwelch(Y(k,j+1:j+1250)',[],0,[],fs);
     [B(j,k,2),f]=pwelch(Y(k,j+1:j+1250)',[],0,[],fs);
     [B(j,k,3),f]=pwelch(Y(k,j+1:j+1250)',[],0,[],fs);
     [B(j,k,4),f]=pwelch(Y(k,j+1:j+1250)',[],0,[],fs);
     [B(j,k,5),f]=pwelch(Y(k,j+1:j+1250)',[],0,[],fs);
     %matrice con epoche,canali, bande mat[epoch,chan,bande]
     %si calcola la psd; %frequenze di taglio delle singole bande 
     %si calcolano le bande di frequenza delle onde;
     %plot(f,pxx)
     
     %delta 1-4 Hz
     Deltapwr=sum(B(j,k,2:6));   
     %Theta 4-8 Hz
     Thetapwr= sum(B(j,k,7:10));
     
     %Alpha 8-13 Hz
     Alphapwr= sum(B(j,k,11:14));
    
     %Beta 13-30 Hz
     Betapwr= sum(B(j,k,15:31));
      
     %Gamma 30-40 Hz
     Gammapwr= sum(B(j,k,32:41));
     
    
   % per_powerDelta = 100*(pbandDelta/ptot);
     Totalbandpwr=Deltapwr+Thetapwr+Alphapwr+Betapwr+Gammapwr;
     Delta=(Deltapwr/Totalbandpwr);
     Theta=(Thetapwr/Totalbandpwr);
     Alpha=(Alphapwr/Totalbandpwr);
     Beta=(Betapwr/Totalbandpwr);
     Gamma=(Gammapwr/Totalbandpwr);
      
     
     
         end
    
     end
     save(strcat(outDir,(strtok(cases(i).name,'.')),'PSD.mat'),'pxx','Delta','Theta','Alpha','Beta','Gamma')
end
 
    
    
end